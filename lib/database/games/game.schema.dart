import 'package:drift/drift.dart';
import 'package:madnolia/database/utils/platform_list_converter.dart';
import 'package:madnolia/database/utils/string_list_converter.dart';

class Game extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  IntColumn get apiId => integer().unique()();
  TextColumn get platforms => text().map(const PlatformListConverter())();
  TextColumn get background => text().nullable()();
  TextColumn get screenshots => text().map(const StringListConverter())();
  TextColumn get description => text()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)(); 

  @override
  Set<Column> get primaryKey => {id};
}