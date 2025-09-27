import 'package:drift/drift.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import '../../enums/connection-status.enum.dart';


class User extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  TextColumn get thumb => text()();
  TextColumn get image => text()();
  IntColumn get connection => intEnum<ConnectionStatus>()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)(); 
  TextColumn get friendshipId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

}

// Extensión para convertir SimpleUser en UserCompanion
extension SimpleUserToUserCompanion on SimpleUser {
  UserCompanion toUserCompanion({
    ConnectionStatus connection = ConnectionStatus.none,
    DateTime? lastUpdated,
    String? friendshipId,
  }) {
    return UserCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      thumb: Value(thumb),
      image: Value(image),
      connection: Value(connection),
      lastUpdated: Value(lastUpdated ?? DateTime.now()),
      friendshipId: Value(friendshipId),
    );
  }
}

// Extensión para convertir SimpleUser en UserData
extension SimpleUserToUserData on SimpleUser {
  UserData toUserData({
    ConnectionStatus connection = ConnectionStatus.none,
    DateTime? lastUpdated,
    String? friendshipId,
  }) {
    return UserData(
      id: id,
      name: name,
      username: username,
      thumb: thumb,
      image: image,
      connection: connection,
      lastUpdated: lastUpdated ?? DateTime.now(),
      friendshipId: friendshipId,
    );
  }
}