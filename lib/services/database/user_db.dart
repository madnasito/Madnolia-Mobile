import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:madnolia/enums/connection-status.enum.dart';

final String tableUser = 'users';
final String columnId = '_id';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnThumb = 'thumb';
final String columnConnection = 'connection';

class UserDb {
  String id;
  String name;
  String username;
  String thumb;
  ConnectionStatus connection;

  UserDb({
    required this.id,
    required this.name,
    required this.username,
    required this.thumb,
    required this.connection,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnUsername: username,
      columnThumb: thumb,
      columnConnection: connection.index,
    };
  }

  factory UserDb.fromMap(Map<String, dynamic> map) {
    ConnectionStatus connectionStatus;
    switch (map[columnConnection]) {
      case 0:
        connectionStatus = ConnectionStatus.none;
        break;
      case 1:
        connectionStatus = ConnectionStatus.requestSent;
        break;
      case 2:
        connectionStatus = ConnectionStatus.requestReceived;
        break;
      case 3:
        connectionStatus = ConnectionStatus.partner;
        break;
      case 4:
        connectionStatus = ConnectionStatus.blocked;
        break;
      default:
        connectionStatus = ConnectionStatus.none;
        break;
    }

    return UserDb(
      id: map[columnId],
      name: map[columnName],
      username: map[columnUsername],
      thumb: map[columnThumb],
      connection: connectionStatus,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserDb.fromJson(String json) => UserDb.fromMap(jsonDecode(json));
}

class UserProvider {
  Database? _db;

  Future open() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/madnolia_users.db';
    
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableUser (
          $columnId TEXT PRIMARY KEY,
          $columnName TEXT NOT NULL,
          $columnUsername TEXT NOT NULL,
          $columnThumb TEXT,
          $columnConnection INTEGER NOT NULL
        )
      ''');
      
      // Create index for faster username searches
      await db.execute('''
        CREATE INDEX idx_username ON $tableUser ($columnUsername)
      ''');
    });
  }

  Future<UserDb> insert(UserDb user) async {
    await _db!.insert(tableUser, user.toMap());
    return user;
  }

  Future<int> insertOrUpdate(UserDb user) async {
    return await _db!.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserDb>> getAllUsers() async {
    final List<Map<String, dynamic>> maps = await _db!.query(tableUser);
    return List.generate(maps.length, (i) => UserDb.fromMap(maps[i]));
  }

  Future<UserDb?> getUser(String id) async {
    final List<Map> maps = await _db!.query(
      tableUser,
      where: '$columnId = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    return maps.isNotEmpty ? UserDb.fromMap(maps.first as Map<String, dynamic>) : null;
  }

  Future<UserDb?> getUserByUsername(String username) async {
    final List<Map> maps = await _db!.query(
      tableUser,
      where: '$columnUsername = ?',
      whereArgs: [username],
      limit: 1,
    );
    
    return maps.isNotEmpty ? UserDb.fromMap(maps.first as Map<String, dynamic>) : null;
  }

  Future<List<UserDb>> getUsersByConnection(ConnectionStatus status) async {
    final List<Map<String, dynamic>> maps = await _db!.query(
      tableUser,
      where: '$columnConnection = ?',
      whereArgs: [status.index],
    );
    
    return List.generate(maps.length, (i) => UserDb.fromMap(maps[i]));
  }

  Future<int> update(UserDb user) async {
    return await _db!.update(
      tableUser,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> updateConnectionStatus(String userId, ConnectionStatus newStatus) async {
    return await _db!.update(
      tableUser,
      {columnConnection: newStatus.index},
      where: '$columnId = ?',
      whereArgs: [userId],
    );
  }

  Future<int> delete(String id) async {
    return await _db!.delete(
      tableUser,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    return await _db!.delete(tableUser);
  }

  Future close() async => _db?.close();
}