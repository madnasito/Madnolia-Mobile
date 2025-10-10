import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/services/friendship_service.dart';

import '../database.dart';

class FriendshipRepository {
  final database = AppDatabase.instance;

  final friendshipService = FriendshipService();

  Future<FriendshipData> getFriendshipById(String id) async {

    try {
      final now = DateTime.now();
      final existingFriendship  = await (database.select(database.friendship)..where((f) => f.id.equals(id))).getSingleOrNull();

      if(existingFriendship != null && now.difference(existingFriendship.lastUpdated).inHours < 1) {
        return existingFriendship;
      }

      final friendshipInfo = await friendshipService.getFriendshipById(id);

      final storage = const FlutterSecureStorage();
      final String? userId = await storage.read(key: "userId");
      final String notMe = friendshipInfo.user1 == userId ? friendshipInfo.user2 : friendshipInfo.user1;

      final friendshipCompanion = FriendshipCompanion(
        id: Value(friendshipInfo.id),
        user: Value(notMe),
        createdAt: Value(friendshipInfo.createdAt),
        status: Value(friendshipInfo.status),
        lastUpdated: Value(now)
      );

      await createOrUpdateFriendship(friendshipCompanion);

      final friendship = await (database.select(database.friendship)..where((friendship) => friendship.id.equals(id))).getSingle();
      return friendship;

    } catch (e) {
      rethrow;
    }

  }

  Future<int> createOrUpdateFriendship(FriendshipCompanion friendship) async{
    try {
      return await database.into(database.friendship).insertOnConflictUpdate(friendship);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteFriendships() async {
    return await database.managers.friendship.delete();
  }
}