import 'package:drift/drift.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/models/user/simple_user_model.dart';

class User extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  TextColumn get thumb => text()();
  TextColumn get image => text()();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)(); 

  @override
  Set<Column> get primaryKey => {id};

}

// Extensión para convertir SimpleUser en UserCompanion
extension SimpleUserToUserCompanion on SimpleUser {
  UserCompanion toUserCompanion({
    DateTime? lastUpdated,
  }) {
    return UserCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      thumb: Value(thumb),
      image: Value(image),
      lastUpdated: Value(lastUpdated ?? DateTime.now()),
    );
  }
}

// Extensión para convertir SimpleUser en UserData
extension SimpleUserToUserData on SimpleUser {
  UserData toUserData({
    DateTime? lastUpdated,
  }) {
    return UserData(
      id: id,
      name: name,
      username: username,
      thumb: thumb,
      image: image,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }
}