import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart' show Lock;


final String tableMatch = 'matches';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnPlatform = 'platform';
final String columnDate = 'date';
final String tableUser = 'users';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnThumb = 'thumb';
final String columnConnection = 'connection';


abstract class BaseDatabaseProvider {
  static Database? _database;
  static final _lock = Lock();

  static Future<Database> get database async {
    await _lock.synchronized(() async {
      if (_database == null || !_database!.isOpen) {
        await _initializeDatabase();
      }
    });
    return _database!;
  }

  static Future<void> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/madnolia.db';

    _database = await openDatabase(
      path,
      version: 1, // Increment when schema changes
      onCreate: (db, version) async {
        await _createUserTable(db);
        await _createMatchTable(db);
        // Add other tables here
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle migrations here
      },
    );
  }

  static Future<void> _createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableUser (
        $columnId TEXT PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnUsername TEXT NOT NULL,
        $columnThumb TEXT NOT NULL,
        $columnConnection INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_username ON $tableUser ($columnUsername)
    ''');
  }

  static Future<void> _createMatchTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableMatch (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnPlatform INTEGER NOT NULL,
        $columnDate INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> close() async {
    await _lock.synchronized(() async {
      if (_database != null && _database!.isOpen) {
        await _database!.close();
      }
      _database = null;
    });
  }
}