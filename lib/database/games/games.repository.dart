import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/database.dart';

import '../../services/games_service.dart';

class GamesRepository {
  final AppDatabase database;

  GamesRepository(this.database);

  final GamesService _gamesService = GamesService();
  
  Future<int> createOrUpdateGame(GameCompanion game) async {
    try {
      return await database.into(database.game).insertOnConflictUpdate(game);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertOrUpdateMany(List<GameCompanion> games) async {
    try {
      return await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.game, games);
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  
  Future<List<GameData>> getGamesByIds(List<String> ids) async {
    try {
      final existingGames = await (database.select(database.game)..where((g) => g.id.isIn(ids))).get();

      final existingGameIds = existingGames.map((g) => g.id).toSet();

      final missingGameIds = ids.where((id) => !existingGameIds.contains(id)).toList();

      if(missingGameIds.isNotEmpty){

        final missingGames = await _gamesService.getGamesByIds(missingGameIds);

        final List<GameCompanion> gamesCompanion = missingGames.map((game) => game.toCompanion()).toList();

        await insertOrUpdateMany(gamesCompanion);
      }

      final allGames = await (database.select(database.game)..where((g) => g.id.isIn(ids))).get();

      return allGames;
    } catch (e) {
      rethrow;
    }
  }


  Future<GameData> getGameById(String id) async {
    try {
      final existsGame = await (database.select(database.game)..where((g) => g.id.equals(id))).getSingleOrNull();
      if(existsGame != null) return existsGame;
      
      final gameInfo = await GamesService().getGameInfoById(id);

      final gameCompanion = GameCompanion(
        id: Value(gameInfo.id),
        name: Value(gameInfo.name),
        slug: Value(gameInfo.slug),
        apiId: Value(gameInfo.gameId),
        background: Value(gameInfo.background),
        description: Value(gameInfo.description),
        screenshots: Value(gameInfo.screenshots),
        platforms: Value(gameInfo.platforms),
      );

      await createOrUpdateGame(gameCompanion);

      final game = await (database.select(database.game)..where((g) => g.id.equals(id))).getSingle();
      return game;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteAllGames() {
    return database.managers.game.delete();
  }
}