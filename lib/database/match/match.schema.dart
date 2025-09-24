import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';

class Match extends Table {
  TextColumn get id => text()();
  TextColumn get game => text()();
  TextColumn get title => text()();
  IntColumn get platform => intEnum<PlatformId>()();
  DateTimeColumn get date => dateTime()();
  TextColumn get user => text()();
  TextColumn get description => text()();
  IntColumn get duration  => integer()();
  BoolColumn get private => boolean()();
  TextColumn get tournament  => text().nullable()();
  IntColumn get status => intEnum<MatchStatus>()();

  // Nuevos campos: listas de String codificadas como JSON
  TextColumn get joined => text().map(const StringListConverter())();
  TextColumn get inviteds => text().map(const StringListConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

// Conversor para listas de String <-> JSON
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return List<String>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}