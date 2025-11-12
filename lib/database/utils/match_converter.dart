
import 'package:drift/drift.dart';

import '../../models/match/match_model.dart';
import '../database.dart';

MatchCompanion matchToCompanion(Match match) {
  return MatchCompanion(
    id: Value(match.id),
    game: Value(match.game),
    title: Value(match.title),
    platform: Value(match.platform),
    date: Value(match.date.toLocal()),
    user: Value(match.user),
    description: Value(match.description),
    duration: Value(match.duration),
    private: Value(match.private),
    tournament: Value(match.tournament),
    status: Value(match.status),
    joined: Value(match.joined),
    inviteds: Value(match.inviteds),
    createdAt: Value(match.createdAt.toLocal())
  );
}
