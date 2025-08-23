import 'dart:convert';

import 'package:madnolia/database/providers/db_provider.dart';

final String tableMatch = 'matches';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnPlatform = 'platform';
final String columnDate = 'date';

class MinimalMatchDb {
  String id;
  String title;
  int platform;
  int date;

  MinimalMatchDb({
    this.id = "",
    required this.title,
    required this.platform,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnPlatform: platform,
      columnDate: date,
    };
    if (id.isNotEmpty) {
      map[columnId] = id;
    }
    return map;
  }

  factory MinimalMatchDb.fromMap(Map<String, dynamic> map) {
    return MinimalMatchDb(
      id: map[columnId]?.toString() ?? '',
      title: map[columnTitle],
      platform: map[columnPlatform],
      date: map[columnDate],
    );
  }

  // Método para convertir a JSON String
  String toJson() {
    return jsonEncode({
      '_id': id,
      'title': title,
      'platform': platform,
      'date': date,
    });
  }

  // Método para crear desde JSON String
  factory MinimalMatchDb.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return MinimalMatchDb(
      id: data['_id']?.toString() ?? '',
      title: data['title'] ?? '',
      platform: data['platform'] ?? 0,
      date: data['date'] ?? 0,
    );
  }
}

class MatchProvider {
  static Future<MinimalMatchDb> insertMatch(MinimalMatchDb match) async {
    final db = await BaseDatabaseProvider.database;
    await db.insert(tableMatch, match.toMap());
    return match;
  }

  static Future<MinimalMatchDb?> getMatch(String id) async {
    final db = await BaseDatabaseProvider.database;
    final List<Map> maps = await db.query(
      tableMatch,
      where: '$columnId = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    return maps.isNotEmpty 
        ? MinimalMatchDb.fromMap(maps.first as Map<String, dynamic>) 
        : null;
  }

  static Future<int> deleteAll() async {
    final db = await BaseDatabaseProvider.database;
    return await db.delete(tableMatch);
  }
  // Other match-specific operations...
}