import 'package:drift/drift.dart';
import 'package:madnolia/database/database.dart';

import '../../services/games_service.dart';

class GamesRepository {
  final database = AppDatabase();
  
  Future<int> createOrUpdateGame(GameCompanion game) async {
    try {
      return await database.into(database.game).insertOnConflictUpdate(game);
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