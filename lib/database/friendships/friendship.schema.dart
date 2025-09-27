import 'package:drift/drift.dart';
import 'package:madnolia/database/users/user.schema.dart';

import '../../enums/friendship-status.enum.dart';

class Friendship extends Table {
  TextColumn get id => text()();
  TextColumn get user => text().references(User, #id)();
  IntColumn get status => intEnum<FriendshipStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
