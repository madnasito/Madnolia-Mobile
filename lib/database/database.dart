import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/notifications_config/notifications_config.schema.dart';
import 'package:madnolia/database/users/user.schema.dart';
import 'package:madnolia/database/friendships/friendship.schema.dart';
import 'package:madnolia/database/match/match.schema.dart';
import 'package:madnolia/database/conversations/conversation.schema.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';

import '../enums/attachment_type.dart';
import '../enums/chat_message_status.enum.dart';
import '../enums/friendship-status.enum.dart';
import '../enums/match-status.enum.dart';
import '../enums/notification_configuration_status.dart';
import '../enums/notification_configuration_type.enum.dart';
import '../enums/notification_type.enum.dart';
import '../enums/platforms_id.enum.dart';
import 'utils/platform_list_converter.dart';
import 'utils/string_list_converter.dart';
import 'chat_messages/chat_message.schema.dart';
import 'attachment/attachment.schema.dart';
import 'games/game.schema.dart';
import 'notifications/notification.schema.dart';

part 'database.g.dart';

class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;
  static bool _initializing = false;
  
  factory AppDatabase() {
    if (_instance != null) return _instance!;
    
    // Prevenir inicialización simultánea
    if (_initializing) {
      throw StateError('AppDatabase is already being initialized');
    }
    
    _initializing = true;
    try {
      _instance = AppDatabase._internal();
      return _instance!;
    } finally {
      _initializing = false;
    }
  }

  @override
  int get schemaVersion => 1;

  AppDatabase._internal([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    debugPrint('database connected');
    return driftDatabase(
      name: 'madnolia',
      native: const DriftNativeOptions(
        // shareAcrossIsolates: true,
        isolateDebugLog: true,
      ),
    );
  }

  // Método para cerrar y resetear (útil para testing)
  static Future<void> resetForTesting() async {
    if (_instance != null) {
      await _instance!.close();
      _instance = null;
    }
  }
}