import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:madnolia/database/drift/users/user.schema.dart';
import 'package:madnolia/database/drift/friendship/friendship.schema.dart';
import 'package:madnolia/database/drift/match/match.schema.dart';

import '../../enums/connection-status.enum.dart';
import '../../enums/friendship-status.enum.dart';

part 'database.g.dart';

@DriftDatabase(tables: [User, Friendship, Match])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 1;

  // Puedes descomentar y usar este método si quieres una conexión por defecto:
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'madnolia',
      native: const DriftNativeOptions(),
    );
  }
}