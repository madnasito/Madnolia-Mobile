import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import '../../models/friendship/friendship_model.dart' show Friendship;

// Definición de la tabla y columnas
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

  // Conversión a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      columnUser1: user1,
      columnUser2: user2,
      columnStatus: status,
      columnCreatedAt: createdAt.toIso8601String(),
      if (id.isNotEmpty) columnId: id,
    };
  }

  // Conversión desde Map de SQLite
  factory FriendshipDb.fromMap(Map<String, dynamic> map) {
    return FriendshipDb(
      id: map[columnId]?.toString() ?? '',
      user1: map[columnUser1]?.toString() ?? '',
      user2: map[columnUser2]?.toString() ?? '',
      status: map[columnStatus] as int? ?? 0,
      createdAt: DateTime.parse(map[columnCreatedAt] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  // Conversión a JSON
  String toJson() => json.encode(toJsonMap());

  Map<String, dynamic> toJsonMap() => {
        "createdAt": createdAt.toIso8601String(),
        "_id": id,
        "user1": user1,
        "user2": user2,
        "status": status,
      };

  // Conversión desde JSON
  factory FriendshipDb.fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return FriendshipDb(
      id: data['_id']?.toString() ?? '',
      user1: data['user1']?.toString() ?? '',
      user2: data['user2']?.toString() ?? '',
      status: data['status'] as int? ?? 0,
      createdAt: DateTime.parse(data['createdAt'] as String? ?? DateTime.now().toIso8601String()),
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
}

class FriendshipProvider {
  Database? _db;

  Future<void> open() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/madna.db';

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableFriendship (
            $columnId TEXT PRIMARY KEY,
            $columnUser1 TEXT NOT NULL,
            $columnUser2 TEXT NOT NULL,
            $columnStatus INTEGER NOT NULL,
            $columnCreatedAt TEXT NOT NULL,
            UNIQUE($columnUser1, $columnUser2) ON CONFLICT REPLACE
          )
        ''');
        
        // Índices para búsquedas rápidas
        await db.execute('''
          CREATE INDEX idx_friendship_user1 ON $tableFriendship($columnUser1)
        ''');
        await db.execute('''
          CREATE INDEX idx_friendship_user2 ON $tableFriendship($columnUser2)
        ''');
        await db.execute('''
          CREATE INDEX idx_friendship_status ON $tableFriendship($columnStatus)
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE INDEX idx_friendship_user1 ON $tableFriendship($columnUser1)
          ''');
        }
      },
    );
  }

  // Operaciones CRUD

  Future<FriendshipDb> insert(FriendshipDb friendship) async {
    // Verifica que el ID ya está asignado (viene de la API)
    if (friendship.id.isEmpty) {
      throw Exception('El ID de la amistad debe estar asignado antes de insertar');
    }

    // Inserta con el ID proporcionado
    await _db!.insert(
      tableFriendship,
      friendship.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Maneja duplicados
    );
    
    return friendship;
  }

  Future<List<FriendshipDb>> getAllFriendships() async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      orderBy: '$columnCreatedAt DESC',
    );
    return maps.map((map) => FriendshipDb.fromMap(map)).toList();
  }

  Future<FriendshipDb?> getFriendship(String id) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return FriendshipDb.fromMap(maps.first);
    }
    return null;
  }

  Future<List<FriendshipDb>> getFriendshipsByUser(String userId) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '$columnUser1 = ? OR $columnUser2 = ?',
      whereArgs: [userId, userId],
      orderBy: '$columnCreatedAt DESC',
    );
    return maps.map((map) => FriendshipDb.fromMap(map)).toList();
  }

  Future<List<FriendshipDb>> getFriendshipsByStatus(int status) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '$columnStatus = ?',
      whereArgs: [status],
      orderBy: '$columnCreatedAt DESC',
    );
    return maps.map((map) => FriendshipDb.fromMap(map)).toList();
  }

  Future<FriendshipDb?> getFriendshipBetweenUsers(String user1, String user2) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableFriendship,
      where: '($columnUser1 = ? AND $columnUser2 = ?) OR ($columnUser1 = ? AND $columnUser2 = ?)',
      whereArgs: [user1, user2, user2, user1],
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

  Future<void> close() async => await _db?.close();
}