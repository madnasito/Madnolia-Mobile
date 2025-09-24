import 'package:drift/drift.dart';
import 'package:madnolia/services/match_service.dart';

import '../database.dart';

class MatchDbServices {

  final database = AppDatabase.instance;

  Future<int> createOrUpdateMatch(MatchCompanion match) async {
    try {
      return await database.into(database.match).insertOnConflictUpdate(match);
    } catch (e) {
      rethrow;
    }
  }

  Future<MatchData> getMatchById(String id) async {

    try {
      final MatchData? existingMatch = await (database.select(database.match)..where((match) => match.id.equals(id))).getSingleOrNull();

      if(existingMatch != null) return existingMatch;

      final matchInfo = await MatchService().getMatch(id);

      final matchCompanion = MatchCompanion(
        id: Value(matchInfo.id),
        game: Value(matchInfo.game),
        title: Value(matchInfo.title),
        platform: Value(matchInfo.platform),
        description: Value(matchInfo.description),
        duration: Value(matchInfo.duration),
        private: Value(matchInfo.private),
        status: Value(matchInfo.status),
        joined: Value(matchInfo.joined),
        inviteds: Value(matchInfo.inviteds)
      );

      await createOrUpdateMatch(matchCompanion);

      final match = await (database.select(database.match)..where((match) => match.id.equals(id))).getSingle();
      return match;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteMatches() async {
    return await database.managers.match.delete();
  }
}