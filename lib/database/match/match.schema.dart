import 'package:drift/drift.dart';
import 'package:madnolia/database/users/user.schema.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';

import '../games/game.schema.dart';
import '../utils/string_list_converter.dart';

class Match extends Table {
  TextColumn get id => text()();
  TextColumn get game => text().references(Game, #id)();
  TextColumn get title => text()();
  IntColumn get platform => intEnum<PlatformId>()();
  DateTimeColumn get date => dateTime()();
  TextColumn get user => text().references(User, #id)();
  TextColumn get description => text()();
  IntColumn get duration  => integer()();
  BoolColumn get private => boolean()();
  TextColumn get tournament  => text().nullable()();
  IntColumn get status => intEnum<MatchStatus>()();
  TextColumn get joined => text().map(const StringListConverter())();
  TextColumn get inviteds => text().map(const StringListConverter())();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
