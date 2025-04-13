import 'package:sqflite/sqflite.dart';

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
}

class MatchProvider {
  Database? _db;

  Future open() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/madnolia.db';
    
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableMatch (
          $columnId TEXT PRIMARY KEY,
          $columnTitle TEXT NOT NULL,
          $columnPlatform INTEGER NOT NULL,
          $columnDate INTEGER NOT NULL
        )
      ''');
    });
  }

  Future<MinimalMatchDb> insert(MinimalMatchDb match) async {
    await _db!.insert(tableMatch, match.toMap());
    return match;
  }

  Future<List<MinimalMatchDb>> getAllMatches() async {
    final List<Map<String, dynamic>> maps = await _db!.query(tableMatch);
    return List.generate(maps.length, (i) {
      return MinimalMatchDb.fromMap(maps[i]);
    });
  }

  Future<MinimalMatchDb?> getMatch(String id) async {
    List<Map> maps = await _db!.query(
      tableMatch,
      columns: [columnId, columnTitle, columnPlatform, columnDate],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MinimalMatchDb.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<int> delete(String id) async {
    return await _db!.delete(
      tableMatch,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(MinimalMatchDb match) async {
    return await _db!.update(
      tableMatch,
      match.toMap(),
      where: '$columnId = ?',
      whereArgs: [match.id],
    );
  }

  Future<int> deleteAll() async {
    return await _db!.delete(tableMatch);
  }

  Future close() async => _db?.close();
}