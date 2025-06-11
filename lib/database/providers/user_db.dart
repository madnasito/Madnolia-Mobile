import 'dart:convert';
import 'package:madnolia/database/providers/db_provider.dart' show BaseDatabaseProvider;
import 'package:madnolia/enums/connection-status.enum.dart';

final String tableUser = 'users';
final String columnId = '_id';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnThumb = 'thumb';
final String columnConnection = 'connection';
final String columnLastUpdated = 'last_updated'; // Nuevo campo añadido

class UserDb {
  String id;
  String name;
  String username;
  String thumb;
  ConnectionStatus connection;
  DateTime lastUpdated; // Nuevo campo añadido

  UserDb({
    required this.id,
    required this.name,
    required this.username,
    required this.thumb,
    required this.connection,
    required this.lastUpdated, // Nuevo campo añadido
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnUsername: username,
      columnThumb: thumb,
      columnConnection: connection.index,
      columnLastUpdated: lastUpdated.millisecondsSinceEpoch, // Guardamos como timestamp
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
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map[columnLastUpdated] ?? 0), // Parseamos el timestamp
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserDb.fromJson(String json) => UserDb.fromMap(jsonDecode(json));
}

class UserProvider {
  static Future<UserDb> insertUser(UserDb user) async {
    final db = await BaseDatabaseProvider.database;
    await db.insert(tableUser, user.toMap());
    return user;
  }

  static Future<UserDb?> getUser(String id) async {
    final db = await BaseDatabaseProvider.database;
    final List<Map> maps = await db.query(
      tableUser,
      where: '$columnId = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    return maps.isNotEmpty 
        ? UserDb.fromMap(maps.first as Map<String, dynamic>) 
        : null;
  }

  static Future<void> clearTable() async {
    final db = await BaseDatabaseProvider.database;
    await db.delete('users');
  }

  static Future<int> updateUser(UserDb user) async {
    final db = await BaseDatabaseProvider.database;
    return await db.update(
      tableUser,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }
}