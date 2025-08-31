import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart' show Lock;

// Tablas y columnas
final String tableMatch = 'matches';
final String tableUser = 'users';
final String tableFriendship = 'friendships';

// Columnas comunes
final String columnId = '_id';

// Columnas específicas
final String columnTitle = 'title';
final String columnPlatform = 'platform';
final String columnDate = 'date';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnThumb = 'thumb';
final String columnConnection = 'connection';
final String columnLastUpdated = 'last_updated';
final String columnUser1 = 'user1';
final String columnUser2 = 'user2';
final String columnStatus = 'status';
final String columnCreatedAt = 'createdAt';

final String columnFriendshipId = 'friendshipId';

abstract class BaseDatabaseProvider {
  static Database? _database;
  static final _lock = Lock();
  static const _databaseVersion = 2; // Incrementado por la nueva tabla

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
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createUserTable(db);
        await _createMatchTable(db);
        await _createFriendshipTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE $tableUser ADD COLUMN $columnFriendshipId TEXT
          ''');
        }
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
        $columnConnection INTEGER NOT NULL,
        $columnLastUpdated INTEGER NOT NULL,
        $columnFriendshipId TEXT
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

  static Future<void> _createFriendshipTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableFriendship (
        $columnId TEXT PRIMARY KEY,
        $columnUser1 TEXT NOT NULL,
        $columnUser2 TEXT NOT NULL,
        $columnStatus INTEGER NOT NULL,
        $columnCreatedAt TEXT NOT NULL,
        $columnLastUpdated TEXT NOT NULL
      )
    ''');
    
    // Crear índices para la tabla de amistades
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_friendship_user1 
      ON $tableFriendship($columnUser1)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_friendship_user2 
      ON $tableFriendship($columnUser2)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_friendship_status 
      ON $tableFriendship($columnStatus)
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