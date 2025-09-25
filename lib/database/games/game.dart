import 'package:drift/drift.dart';
import 'package:madnolia/utils/int_list_converter_drift.dart';
import 'package:madnolia/utils/string_list_converter_drift.dart';

class Game extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  TextColumn get apiId => text().unique()();
  TextColumn get platforms => text().map(const IntListConverter())();
  TextColumn get background => text()();
  TextColumn get screenshots => text().map(const StringListConverter())();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}