import 'package:drift/drift.dart';
import 'package:madnolia/database/users/user.schema.dart';
import 'package:madnolia/enums/notification_type.enum.dart';

class Notification extends Table {
  TextColumn get id => text()();
  IntColumn get type => intEnum<NotificationType>()();
  TextColumn get title => text()();
  TextColumn get thumb => text()();
  TextColumn get sender => text().nullable().references(User, #id)();
  TextColumn get path => text()();
  BoolColumn get read => boolean()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}