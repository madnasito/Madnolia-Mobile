import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:madnolia/database/drift/database.dart';
import 'package:madnolia/database/drift/users/user.schema.dart';

import '../../../services/user_service.dart';

class UserDbServices {

  final database = AppDatabase.instance;

  Future<int> createOrUpdateUser(UserCompanion user) {
    try {
      return database.into(database.user).insertOnConflictUpdate(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData> getUserById(String id) async {
    try {
      final now = DateTime.now();
      final UserData? existingUser = await (database.select(database.user)..where((user) => user.id.equals(id))).getSingleOrNull();

      // Return cached user if recent
      if (existingUser != null && now.difference(existingUser.lastUpdated).inHours < 1) {
        return existingUser;
      }
      
      // Fetch fresh data
      final userInfo = await UserService().getUserInfoById(id);
      
      
      final userCompanion = UserCompanion(
        id: Value(userInfo.id),
        name: Value(userInfo.name),
        username: Value(userInfo.username),
        thumb: Value(userInfo.thumb),
        connection: Value(userInfo.connection),
        lastUpdated: Value(now),
      );

      await createOrUpdateUser(userCompanion);
      
      final user = await (database.select(database.user)..where((user) => user.id.equals(id))).getSingle();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData?> getUserByFriendship(String friendshipId) async {
    try {
      return await (database.select(database.user)..where((user) => user.friendshipId.equals(friendshipId))).getSingleOrNull();
    } catch (e) {
      debugPrint('Error in getUserByFriendship: $e');
      return null;
    }
  }

  Future<User> updateUser(User user) async {
    // This method should probably update the user in the database.
    // The current implementation is just returning the user.
    // I will leave it as it is for now as it is not part of the request.
    return user;
  }

  Future<int> deleteUsers() async {
    return await database.managers.user.delete();
  }
}