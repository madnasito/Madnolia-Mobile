import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import '../../models/friendship/friendship_model.dart' show Friendship;

final String tableFriendship = 'friendships';
final String columnId = '_id';
final String columnUser1 = 'user1';
final String columnUser2 = 'user2';
final String columnStatus = 'status';
final String columnCreatedAt = 'createdAt';

class FriendshipDb {
  String id;
  String user1;
  String user2;
  int status;
  DateTime createdAt;

  FriendshipDb({
    this.id = "",
    required this.user1,
    required this.user2,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUser1: user1,
      columnUser2: user2,
      columnStatus: status,
      columnCreatedAt: createdAt.toIso8601String(),
    };
    if (id.isNotEmpty) {
      map[columnId] = id;
    }
    return map;
  }

  factory FriendshipDb.fromMap(Map<String, dynamic> map) {
    return FriendshipDb(
      id: map[columnId]?.toString() ?? '',
      user1: map[columnUser1],
      user2: map[columnUser2],
      status: map[columnStatus],
      createdAt: DateTime.parse(map[columnCreatedAt]),
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'user1': user1,
      'user2': user2,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    });
  }

  factory FriendshipDb.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return FriendshipDb(
      id: data['_id']?.toString() ?? '',
      user1: data['user1'] ?? '',
      user2: data['user2'] ?? '',
      status: data['status'] ?? 0,
      createdAt: DateTime.parse(data['createdAt']),
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
  Database? _db;

  Future open() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/madnolia.db';
  
  // Añade onOpen y aumenta la versión para forzar recreación si es necesario
  _db = await openDatabase(
    path, 
    version: 1, // Incrementa la versión
    onCreate: (Database db, int version) async {
      await _createTables(db);
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute('DROP TABLE IF EXISTS $tableFriendship');
      await _createTables(db);
    },
  );
}

Future _createTables(Database db) async {
  await db.execute('''
    CREATE TABLE $tableFriendship (
      $columnId TEXT PRIMARY KEY,
      $columnUser1 TEXT NOT NULL,
      $columnUser2 TEXT NOT NULL,
      $columnStatus INTEGER NOT NULL,
      $columnCreatedAt TEXT NOT NULL
    )
  ''');
  
    // Crear índices
    await db.execute('CREATE INDEX idx_user1 ON $tableFriendship ($columnUser1)');
    await db.execute('CREATE INDEX idx_user2 ON $tableFriendship ($columnUser2)');
    await db.execute('CREATE INDEX idx_status ON $tableFriendship ($columnStatus)');
  }

  Future<FriendshipDb> insert(FriendshipDb friendship) async {
    await _db!.insert(tableFriendship, friendship.toMap());
    return friendship;
  }

  Future<List<FriendshipDb>> getAllFriendships() async {
    final List<Map<String, dynamic>> maps = await _db!.query(tableFriendship);
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  Future<FriendshipDb?> getFriendship(String id) async {
    List<Map> maps = await _db!.query(
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
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '$columnUser1 = ? OR $columnUser2 = ?',
      whereArgs: [userId, userId],
    );
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  Future<List<FriendshipDb>> getFriendshipsByStatus(int status) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '$columnStatus = ?',
      whereArgs: [status],
    );
    return List.generate(maps.length, (i) {
      return FriendshipDb.fromMap(maps[i]);
    });
  }

  Future<FriendshipDb?> getFriendshipBetweenUsers(String user1, String user2) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
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

  Future<int> update(FriendshipDb friendship) async {
    return await _db!.update(
      tableFriendship,
      friendship.toMap(),
      where: '$columnId = ?',
      whereArgs: [friendship.id],
    );
  }

  Future<int> updateStatus(String id, int newStatus) async {
    return await _db!.update(
      tableFriendship,
      {columnStatus: newStatus},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String id) async {
    return await _db!.delete(
      tableFriendship,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    return await _db!.delete(tableFriendship);
  }

  Future close() async => _db?.close();
}