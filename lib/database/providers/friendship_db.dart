import 'dart:convert';
import 'package:madnolia/database/providers/db_provider.dart';
import 'package:madnolia/enums/friendship-status.enum.dart';

import '../../models/friendship/friendship_model.dart' show Friendship;

final String tableFriendship = 'friendships';
final String columnId = '_id';
final String columnUser1 = 'user1';
final String columnUser2 = 'user2';
final String columnStatus = 'status';
final String columnCreatedAt = 'createdAt';
final String columnLastUpdated = 'last_updated';

class FriendshipDb {
  String id;
  String user1;
  String user2;
  FriendshipStatus status;
  DateTime createdAt;
  DateTime lastUpdated; // Nuevo campo

  FriendshipDb({
    this.id = "",
    required this.user1,
    required this.user2,
    required this.status,
    required this.createdAt,
    DateTime? lastUpdated, // Hacemos opcional para manejar casos donde no exista
  }) : lastUpdated = lastUpdated ?? createdAt;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUser1: user1,
      columnUser2: user2,
      columnStatus: status.index,
      columnCreatedAt: createdAt.toIso8601String(),
      columnLastUpdated: lastUpdated.toIso8601String(), // Nuevo campo
    };
    if (id.isNotEmpty) {
      map[columnId] = id;
    }
    return map;
  }

  factory FriendshipDb.fromMap(Map<String, dynamic> map) {
    final FriendshipStatus friendshipStatus;

    switch (map[columnStatus]) {
      case 0:
          friendshipStatus = FriendshipStatus.alive;
        break;
      case 1:
        friendshipStatus = FriendshipStatus.broke;
        break;
      default:
        friendshipStatus = FriendshipStatus.broke;
        break;
    }
    return FriendshipDb(
      id: map[columnId]?.toString() ?? '',
      user1: map[columnUser1],
      user2: map[columnUser2],
      status: friendshipStatus,
      createdAt: DateTime.parse(map[columnCreatedAt]),
      lastUpdated: DateTime.parse(map[columnLastUpdated] ?? map[columnCreatedAt]),
    );
  }

  // String toJson() {
  //   return jsonEncode({
  //     '_id': id,
  //     'user1': user1,
  //     'user2': user2,
  //     'status': status,
  //     'createdAt': createdAt.toIso8601String(),
  //     'lastUpdated': createdAt.toIso8601String(),
  //   });
  // }

  factory FriendshipDb.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return FriendshipDb(
      id: data['_id']?.toString() ?? '',
      user1: data['user1'] ?? '',
      user2: data['user2'] ?? '',
      status: data['status'] ?? 0,
      createdAt: DateTime.parse(data['createdAt']),
      lastUpdated: DateTime.now()
    );
  }

  // Conversión desde el modelo original Friendship
  factory FriendshipDb.fromFriendship(Friendship friendship) {

    return FriendshipDb(
      id: friendship.id,
      user1: friendship.user1,
      user2: friendship.user2,
      status: friendship.status,
      createdAt: friendship.createdAt,
      lastUpdated: DateTime.now(),
    );
  }

  // Conversión al modelo original Friendship
  Friendship toFriendship() {
    return Friendship(
      id: id,
      user1: user1,
      user2: user2,
      status: status,
      createdAt: createdAt,
    );
  }
}

class FriendshipProvider {

  
  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 1) {
  //     await db.execute('DROP TABLE IF EXISTS $tableFriendship');
  //     await _onCreate(db, newVersion);
  //   }
  // }

  // Future<void> _createIndexes(Database db) async {
  //   await db.execute('''
  //     CREATE INDEX IF NOT EXISTS idx_friendship_user1 
  //     ON $tableFriendship($columnUser1)
  //   ''');
  //   await db.execute('''
  //     CREATE INDEX IF NOT EXISTS idx_friendship_user2 
  //     ON $tableFriendship($columnUser2)
  //   ''');
  //   await db.execute('''
  //     CREATE INDEX IF NOT EXISTS idx_friendship_status 
  //     ON $tableFriendship($columnStatus)
  //   ''');
  // }

  // Método para verificar si la tabla existe
  Future<bool> tableExists() async {
    try {
      final db = await BaseDatabaseProvider.database;
      await db.rawQuery('SELECT 1 FROM $tableFriendship LIMIT 1');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<FriendshipDb> insert(FriendshipDb friendship) async {
    final db = await BaseDatabaseProvider.database;
    await db.insert(tableFriendship, friendship.toMap());
    return friendship;
  }

  Future<List<FriendshipDb>> getAllFriendships() async {
    final db = await BaseDatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(tableFriendship);
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  static Future<FriendshipDb?> getFriendship(String id) async {
    final db = await BaseDatabaseProvider.database;
    List<Map> maps = await db.query(
      tableFriendship,
      columns: [columnId, columnUser1, columnUser2, columnStatus, columnCreatedAt],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return FriendshipDb.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<FriendshipDb>> getFriendshipsByUser(String userId) async {
    final db = await BaseDatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableFriendship,
      where: '$columnUser1 = ? OR $columnUser2 = ?',
      whereArgs: [userId, userId],
    );
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  Future<List<FriendshipDb>> getFriendshipsByStatus(int status) async {
    final db = await BaseDatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableFriendship,
      where: '$columnStatus = ?',
      whereArgs: [status],
    );
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  Future<FriendshipDb?> getFriendshipBetweenUsers(String user1, String user2) async {
    final db = await BaseDatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableFriendship,
      where: '($columnUser1 = ? AND $columnUser2 = ?) OR ($columnUser1 = ? AND $columnUser2 = ?)',
      whereArgs: [user1, user2, user2, user1],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return FriendshipDb.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> update(FriendshipDb friendship) async {
    final db = await BaseDatabaseProvider.database;
    return await db.update(
      tableFriendship,
      friendship.toMap(),
      where: '$columnId = ?',
      whereArgs: [friendship.id],
    );
  }

  Future<int> updateStatus(String id, int newStatus) async {
    final db = await BaseDatabaseProvider.database;
    return await db.update(
      tableFriendship,
      {columnStatus: newStatus},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String id) async {
    final db = await BaseDatabaseProvider.database;
    return await db.delete(
      tableFriendship,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAll() async {
    final db = await BaseDatabaseProvider.database;
    return await db.delete(tableFriendship);
  }

}