// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:madnolia/database/providers/db_provider.dart' show BaseDatabaseProvider;
// import 'package:madnolia/database/services/user-db.service.dart';
// import 'package:madnolia/enums/connection-status.enum.dart';
// import 'package:madnolia/services/friendship_service.dart';
// import 'package:sqflite/sqflite.dart';

// final String tableUser = 'users';
// final String columnId = '_id';
// final String columnName = 'name';
// final String columnUsername = 'username';
// final String columnThumb = 'thumb';
// final String columnConnection = 'connection';
// final String columnLastUpdated = 'last_updated'; // Nuevo campo añadido
// final String columnFriendshipId = 'friendshipId';

// class UserDb {
//   String id;
//   String name;
//   String username;
//   String thumb;
//   ConnectionStatus connection;
//   DateTime lastUpdated; // Nuevo campo añadido
//   String? friendshipId;

//   UserDb({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.thumb,
//     required this.connection,
//     required this.lastUpdated, // Nuevo campo añadido
//     this.friendshipId
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       columnId: id,
//       columnName: name,
//       columnUsername: username,
//       columnThumb: thumb,
//       columnConnection: connection.index,
//       columnLastUpdated: lastUpdated.millisecondsSinceEpoch, // Guardamos como timestamp
//       columnFriendshipId: friendshipId
//     };
//   }

//   factory UserDb.fromMap(Map<String, dynamic> map) {
//     ConnectionStatus connectionStatus;
//     switch (map[columnConnection]) {
//       case 0:
//         connectionStatus = ConnectionStatus.none;
//         break;
//       case 1:
//         connectionStatus = ConnectionStatus.requestSent;
//         break;
//       case 2:
//         connectionStatus = ConnectionStatus.requestReceived;
//         break;
//       case 3:
//         connectionStatus = ConnectionStatus.partner;
//         break;
//       case 4:
//         connectionStatus = ConnectionStatus.blocked;
//         break;
//       default:
//         connectionStatus = ConnectionStatus.none;
//         break;
//     }

//     return UserDb(
//       id: map[columnId],
//       name: map[columnName],
//       username: map[columnUsername],
//       thumb: map[columnThumb],
//       connection: connectionStatus,
//       lastUpdated: DateTime.fromMillisecondsSinceEpoch(map[columnLastUpdated] ?? 0), // Parseamos el timestamp
//       friendshipId: map[columnFriendshipId]
//     );
//   }

//   String toJson() => jsonEncode(toMap());

//   factory UserDb.fromJson(String json) => UserDb.fromMap(jsonDecode(json));
// }

// class UserProvider {
//   static Future<UserDb> insertUser(UserDb user) async {
//     final db = await BaseDatabaseProvider.database;
//     await db.insert(
//       tableUser, 
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace, // This will replace on conflict
//     );
//     return user;
//   }

//   static Future<UserDb?> getUser(String id) async {
//     final db = await BaseDatabaseProvider.database;
//     final List<Map> maps = await db.query(
//       tableUser,
//       where: '$columnId = ?',
//       whereArgs: [id],
//       limit: 1,
//     );
    
//     return maps.isNotEmpty 
//         ? UserDb.fromMap(maps.first as Map<String, dynamic>) 
//         : null;
//   }

//   static Future<void> clearTable() async {
//     final db = await BaseDatabaseProvider.database;
//     await db.delete('users');
//   }

//   static Future<int> updateUser(UserDb user) async {
//     final db = await BaseDatabaseProvider.database;
//     return await db.update(
//       tableUser,
//       user.toMap(),
//       where: '$columnId = ?',
//       whereArgs: [user.id],
//     );
//   }

//   static Future<UserDb?> getUserByFriendship(String friendshipId) async {
//     final db = await BaseDatabaseProvider.database;
//     List<Map> maps = await db.query(
//       tableUser,
//       where: '$columnFriendshipId = ?',
//       whereArgs: [friendshipId],
//       limit: 1,
//     );

//     if (maps.isNotEmpty) {
//       return UserDb.fromMap(maps.first as Map<String, dynamic>);
//     } else {
//       // User not found, so fetch friendship, get other user, save and return
//       try {
//         final friendship = await FriendshipService().getFriendshipById(friendshipId);
//         const storage = FlutterSecureStorage();
//         final currentUserId = await storage.read(key: "userId");
//         final otherUserId = friendship.user1 == currentUserId ? friendship.user2 : friendship.user1;

//         // Now get the user data, which will fetch and save it to the DB
//         UserDb user = await getUserDb(otherUserId);

//         // Update the user with the friendshipId
//         user.friendshipId = friendshipId;
//         await updateUser(user);

//         return user;
//       } catch (e) {
//         debugPrint("Error in getUserByFriendship: $e");
//         rethrow;
//       }
//     }
//   }
// }
