import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/users/user.schema.dart';
import '../../services/user_service.dart';

class UserRepository {
  final AppDatabase database;

  UserRepository(this.database);

  Future<int> createOrUpdateUser(UserCompanion user) async {
    try {
      return await database.into(database.user).insertOnConflictUpdate(user);
    } catch (e) {
      debugPrint('Error in createOrUpdateUser: $e');
      rethrow;
    }
  }

  Future<UserData> getUserById(String id) async {
    try {
      final now = DateTime.now();
      final UserData? existingUser = await (database.select(
        database.user,
      )..where((user) => user.id.equals(id))).getSingleOrNull();

      // Return cached user if recent
      if (existingUser != null &&
          now.difference(existingUser.lastUpdated).inHours < 1) {
        return existingUser;
      }

      // Fetch fresh data
      final userInfo = await UserService().getUserInfoById(id);

      final userCompanion = UserCompanion(
        id: Value(userInfo.id),
        image: Value(userInfo.image),
        name: Value(userInfo.name),
        username: Value(userInfo.username),
        thumb: Value(userInfo.thumb),
        lastUpdated: Value(now),
      );

      await createOrUpdateUser(userCompanion);

      final user = await (database.select(
        database.user,
      )..where((user) => user.id.equals(id))).getSingleOrNull();
      return user ?? userInfo.toUserData(lastUpdated: now);
    } catch (e) {
      debugPrint('Error in getUserById: $e');
      rethrow;
    }
  }

  Future<List<UserData>> getUsersByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    try {
      final existingUsers = await (database.select(
        database.user,
      )..where((user) => user.id.isIn(ids))).get();

      final existingUserIds = existingUsers.map((u) => u.id).toSet();
      final unknownUserIds = ids
          .where((id) => !existingUserIds.contains(id))
          .toList();

      if (unknownUserIds.isEmpty) {
        return existingUsers;
      }

      final freshUsersInfo = await UserService().getUsersInfoByIds(
        unknownUserIds,
      );

      if (freshUsersInfo.isNotEmpty) {
        final userCompanions = freshUsersInfo.map((userInfo) {
          return UserCompanion(
            id: Value(userInfo.id),
            image: Value(userInfo.image),
            name: Value(userInfo.name),
            username: Value(userInfo.username),
            thumb: Value(userInfo.thumb),
            lastUpdated: Value(DateTime.now()),
          );
        }).toList();

        await database.batch((batch) {
          batch.insertAllOnConflictUpdate(database.user, userCompanions);
        });
      }

      return await (database.select(
        database.user,
      )..where((user) => user.id.isIn(ids))).get();
    } catch (e) {
      debugPrint('Error in getUsersByIds: $e');
      rethrow;
    }
  }

  Future<UserData?> getUserByFriendship(String friendshipId) async {
    try {
      final friendship = await (database.select(
        database.friendship,
      )..where((f) => f.id.equals(friendshipId))).getSingleOrNull();
      if (friendship == null) return null;
      return await getUserById(friendship.user);
    } catch (e) {
      debugPrint('Error in getUserByFriendship: $e');
      return null;
    }
  }

  Future<int> deleteUsers() async {
    return await database.managers.user.delete();
  }
}
