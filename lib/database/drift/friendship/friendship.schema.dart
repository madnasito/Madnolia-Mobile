import 'package:drift/drift.dart';

class Friendship extends Table {
  TextColumn get id => text()();
  TextColumn get user1 => text()();
  TextColumn get user2 => text()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
