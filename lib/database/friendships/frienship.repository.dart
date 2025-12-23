import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/services/friendship_service.dart';

import '../database.dart';

class FriendshipRepository {
  final AppDatabase database;

  FriendshipRepository(this.database);

  final friendshipService = FriendshipService();

  Future<List<FriendshipData>> getAllFriendships({bool reload = false }) async {
    try {
      final now = DateTime.now();
      final existingFriendships = await database.select(database.friendship).get();

      if (existingFriendships.isNotEmpty && now.difference(existingFriendships.first.lastUpdated).inHours < 1 && !reload) {
        return existingFriendships;
      }

      final friendships = await friendshipService.getAllFriendships();

      for (final friendship in friendships) {
        final storage = const FlutterSecureStorage();
        final String? userId = await storage.read(key: "userId");
        final String notMe = friendship.user1 == userId ? friendship.user2 : friendship.user1;

        final friendshipCompanion = FriendshipCompanion(
          id: Value(friendship.id),
          user: Value(notMe),
          createdAt: Value(friendship.createdAt),
          status: Value(friendship.status),
          lastUpdated: Value(now),
        );

        await createOrUpdateFriendship(friendshipCompanion);
      }

      return await database.select(database.friendship).get();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

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

  Future <List<FriendshipData>> getFriendshipsByIds({required List<String> ids, bool reload = false }) async {
    try {
      final now = DateTime.now();
      
      if (reload) {
        final apiFriendships = await friendshipService.getFriendshipsByIds(ids);
        final storage = const FlutterSecureStorage();
        final String? userId = await storage.read(key: "userId");

        for (final friendshipInfo in apiFriendships) {
          final String notMe = friendshipInfo.user1 == userId ? friendshipInfo.user2 : friendshipInfo.user1;

          final friendshipCompanion = FriendshipCompanion(
            id: Value(friendshipInfo.id),
            user: Value(notMe),
            createdAt: Value(friendshipInfo.createdAt),
            status: Value(friendshipInfo.status),
            lastUpdated: Value(now),
          );
          await createOrUpdateFriendship(friendshipCompanion);
        }
        final allFriendships = await (database.select(database.friendship)..where((f) => f.id.isIn(ids))).get();
        return allFriendships;
      }


      final List<String> idsToFetch = [];

      // Check local database for existing and fresh friendships
      final existingFriendships = await (database.select(database.friendship)..where((f) => f.id.isIn(ids))).get();

      for (final id in ids) {
        final existing = existingFriendships.where((f) => f.id == id).firstOrNull;
        if (existing == null) {
          idsToFetch.add(id);
        }
      }

      // Fetch remaining friendships from API
      if (idsToFetch.isNotEmpty) {
        final apiFriendships = await friendshipService.getFriendshipsByIds(idsToFetch);

        final storage = const FlutterSecureStorage();
        final String? userId = await storage.read(key: "userId");

        for (final friendshipInfo in apiFriendships) {
          final String notMe = friendshipInfo.user1 == userId ? friendshipInfo.user2 : friendshipInfo.user1;

          final friendshipCompanion = FriendshipCompanion(
            id: Value(friendshipInfo.id),
            user: Value(notMe),
            createdAt: Value(friendshipInfo.createdAt),
            status: Value(friendshipInfo.status),
            lastUpdated: Value(now),
          );
          await createOrUpdateFriendship(friendshipCompanion);
        }
      }

      // Retrieve all requested friendships from local database
      final allFriendships = await (database.select(database.friendship)..where((f) => f.id.isIn(ids))).get();
      return allFriendships;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<FriendshipData> getFriendshipByUserId(String id) async {
    try {
      final now = DateTime.now();
      final existingFriendships  = await (database.select(database.friendship)..where((f) => f.user.equals(id))).get();
      final existingFriendship = existingFriendships.isNotEmpty ? existingFriendships.first : null;

      if(existingFriendship != null && now.difference(existingFriendship.lastUpdated).inHours < 1) {
        return existingFriendship;
      }

      final friendshipInfo = await friendshipService.getFriendwhipWithUser(id);

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

      final friendship = await (database.select(database.friendship)..where((friendship) => friendship.id.equals(friendshipInfo.id))).getSingle();
      return friendship;
    } catch (e) {
      debugPrint(e.toString());
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