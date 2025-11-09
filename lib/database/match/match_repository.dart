import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/database/games/games.repository.dart';
import 'package:madnolia/database/users/user_repository.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/services/match_service.dart';

import '../../enums/sort_type.enum.dart';
import '../../models/match/match_model.dart';

import '../../models/match/match_with_game_model.dart';
import '../../models/match/matches-filter.model.dart';
import '../database.dart';
import '../utils/match_converter.dart';

class MatchRepository {

  final AppDatabase database;

  final MatchService _matchService = MatchService();
  final _storage = FlutterSecureStorage();
  late final GamesRepository _gamesRepository;
  late final UserRepository _userRepository;

  MatchRepository(this.database) {
    _gamesRepository = GamesRepository(database);
    _userRepository = UserRepository(database);
  }

  Future<int> createOrUpdateMatch(MatchCompanion match) async {
    try {
      return await database.into(database.match).insertOnConflictUpdate(match);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertOrUpdateMany(List <MatchCompanion> matches) async {
    try {

      final List<String> users = matches.map((match) => match.user.value).toSet().toList();

      List<String> games = matches.map((match) => match.game.value).toSet().toList();

      // Verifyng all senders
      await _userRepository.getUsersByIds(users);

      // Verifyng all games
      await _gamesRepository.getGamesByIds(games);


      return await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.match, matches);
      });
    } catch (e) {
      debugPrint(e.toString());
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
      await _gamesRepository.getGameById(matchInfo.game); // Ensures game is cached
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

  Future<List<MatchWithGame>> getMatchesWithGame({required MatchesFilter filter, required bool reload}) async {
    final currentUserId = await _storage.read(key: 'userId');

    if(currentUserId == null) throw "No user Id";

    if(reload == true) await updateData(filter);

    final select = database.select(database.match);

    if (filter.type == MatchesFilterType.created) {
      select.where((tbl) => tbl.user.equals(currentUserId));
    } else if (filter.type == MatchesFilterType.joined) {
      select.where((tbl) => tbl.joined.contains(currentUserId));
    } else {
      select.where((tbl) => tbl.user.equals(currentUserId) | tbl.joined.contains(currentUserId));
    }

    if (filter.platform != null) {
      select.where((tbl) => tbl.platform.equals(filter.platform!.id)); // Assuming PlatformId has an 'id' property
    }

    select
      ..limit(filter.limit, offset: filter.skip)
      ..orderBy([
        (m) {
          final orderTerm = filter.sort == SortType.asc
              ? OrderingTerm.asc(m.date)
              : OrderingTerm.desc(m.date);
          return orderTerm;
        }
      ]);

    final joinedQuery = select.join([
      innerJoin(database.game, database.game.id.equalsExp(database.match.game))
    ]);

    final rows = await joinedQuery.get();

    if(rows.length < filter.limit && reload == false) {
      await updateData(filter);
      return getMatchesWithGame(filter: filter, reload: false);
    }

    return rows.map((row) {
      final matchData = row.readTable(database.match);
      final gameData = row.readTable(database.game);
      return MatchWithGame(match: matchData, game: gameData);
    }).toList();
  }

  Future updateData(MatchesFilter filter) async {
    try {
      List<Match> apiMatches = await _matchService.getMatches(filter);

      final matchCompanions = apiMatches.map((match) => matchToCompanion(match)).toList();

      return await insertOrUpdateMany(matchCompanions);
    } catch (e) {
      rethrow;
    }
  }
  Future<int> joinUser(String matchId, String userId) async {
    try {
      final match = await (database.select(database.match)..where((m) => m.id.equals(matchId))).getSingle();

      await _userRepository.getUserById(userId);
      
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
        _userRepository.getUserById(matchInfo.user),
        _gamesRepository.getGameById(matchInfo.game)
      ]);

      final matchCompanion = matchToCompanion(matchInfo);

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
