import 'package:drift/drift.dart';

class Match extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get platform => integer()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}