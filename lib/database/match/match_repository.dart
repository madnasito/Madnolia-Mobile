import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/games/games.repository.dart';
import 'package:madnolia/database/users/user_repository.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/services/match_service.dart';

import '../../models/match/match_model.dart';

import '../database.dart';

class MatchRepository {

  final database = AppDatabase.instance;

  MatchCompanion matchToCompanion(Match match) {
    return MatchCompanion(
      id: Value(match.id),
      game: Value(match.game),
      title: Value(match.title),
      platform: Value(match.platform),
      date: Value(DateTime.fromMillisecondsSinceEpoch(match.date)),
      user: Value(match.user),
      description: Value(match.description),
      duration: Value(match.duration),
      private: Value(match.private),
      tournament: Value(match.tournament),
      status: Value(match.status),
      joined: Value(match.joined),
      inviteds: Value(match.inviteds),
    );
  }

  Future<int> createOrUpdateMatch(MatchCompanion match) async {
    try {
      return await database.into(database.match).insertOnConflictUpdate(match);
    } catch (e) {
      rethrow;
    }
  }

  Future<MatchWithGame> getMatchWithGame(String matchId) async {
    final joinedQuery = (database.select(database.match)..where((m) => m.id.equals(matchId)))
        .join([
          innerJoin(database.game, database.game.id.equalsExp(database.match.game))
        ]);

    var row = await joinedQuery.getSingleOrNull();

    if (row == null) {
      // Data not found locally, fetch from remote
      final matchInfo = await MatchService().getMatch(matchId);
      await GamesRepository().getGameById(matchInfo.game); // Ensures game is cached
      await createOrUpdateMatch(matchToCompanion(matchInfo)); // Caches match

      // Retry the query now that data should be in the DB
      row = await joinedQuery.getSingleOrNull();

      // If it's still null after fetching, something is fundamentally wrong.
      if (row == null) {
        throw Exception('Failed to load match data even after fetching from remote.');
      }
    }

    final matchData = row.readTable(database.match);
    final gameData = row.readTable(database.game);
    return MatchWithGame(match: matchData, game: gameData);
  }


  Future<int> joinUser(String matchId, String userId) async {
    try {
      final match = await (database.select(database.match)..where((m) => m.id.equals(matchId))).getSingle();
      final updatedJoined = List<String>.from(match.joined)..add(userId);

      final updatedMatch = MatchCompanion(
        joined: Value(updatedJoined),
      );

      return await (database.update(database.match)..where((m) => m.id.equals(matchId))).write(updatedMatch);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<MatchData> getMatchById(String id) async {
    try {
      final MatchData? existingMatch = await (database.select(database.match)..where((match) => match.id.equals(id))).getSingleOrNull();

      if (existingMatch != null) {
        final now = DateTime.now();
        final difference = now.difference(existingMatch.lastUpdated);
        if (difference.inMinutes <= 30) {
          return existingMatch;
        }
      }

      final matchInfo = await MatchService().getMatch(id);

      await Future.wait([
        UserRepository().getUserById(matchInfo.user),
        GamesRepository().getGameById(matchInfo.game)
      ]);

      final matchCompanion = MatchCompanion(
        id: Value(matchInfo.id),
        game: Value(matchInfo.game),
        user: Value(matchInfo.user),
        date: Value(DateTime.fromMillisecondsSinceEpoch(matchInfo.date)),
        title: Value(matchInfo.title),
        platform: Value(matchInfo.platform),
        description: Value(matchInfo.description),
        duration: Value(matchInfo.duration),
        private: Value(matchInfo.private),
        status: Value(matchInfo.status),
        joined: Value(matchInfo.joined),
        inviteds: Value(matchInfo.inviteds),
        lastUpdated: Value(DateTime.now()),
      );

      await createOrUpdateMatch(matchCompanion);

      final match = await (database.select(database.match)..where((match) => match.id.equals(id))).getSingle();
      return match;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<int> updateMatchStatus(String matchId, MatchStatus status) async {
    try {
      final updatedMatch = MatchCompanion(
        status: Value(status),
      );

      return await (database.update(database.match)..where((m) => m.id.equals(matchId))).write(updatedMatch);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteMatches() async {
    return await database.managers.match.delete();
  }
}

class MatchWithGame {
  final MatchData match;
  final GameData game;
  MatchWithGame({required this.match, required this.game});
}
