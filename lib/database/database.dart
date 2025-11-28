import 'dart:convert';

import 'package:drift/drift.dart';
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

@DriftDatabase(tables: [
  User,
  Friendship,
  Match,
  Conversation,
  ChatMessage,
  Attachment,
  Game,
  Notification,
  NotificationsConfig
])

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
     driftRuntimeOptions.defaultSerializer = const CustomValueSerializer();
    return driftDatabase(
      name: 'madnolia',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
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

class CustomValueSerializer extends ValueSerializer {
  const CustomValueSerializer();

  @override
  T fromJson<T>(dynamic json) {
    if (json == null) {
      return null as T;
    }

    // Manejar específicamente List<String>
    final tString = T.toString();
    if (tString == 'List<String>' || tString == 'List<String>?') {
      if (json is List) {
        return json.map((item) => item.toString()).cast<String>().toList() as T;
      } else if (json is String) {
        // Por si viene como string JSON
        try {
          final parsed = jsonDecode(json) as List;
          return parsed.map((item) => item.toString()).cast<String>().toList() as T;
        } catch (e) {
          return [] as T;
        }
      }
      return [] as T;
    }

    // Manejar List<dynamic> explícitamente
    if (T.toString().startsWith('List<') && json is List) {
      // Para cualquier tipo de lista, hacer conversión segura
      final typeString = T.toString();
      if (typeString.contains('String')) {
        return json.map((item) => item.toString()).cast<String>().toList() as T;
      }
      // Puedes agregar más casos específicos aquí si es necesario
    }

    // Copiar el comportamiento por defecto para otros tipos
    final typeList = <T>[];

    if (typeList is List<DateTime?>) {
      if (json is int) {
        return DateTime.fromMillisecondsSinceEpoch(json) as T;
      } else {
        return DateTime.parse(json.toString()) as T;
      }
    }

    if (typeList is List<double?> && json is int) {
      return json.toDouble() as T;
    }

    if (typeList is List<Uint8List?> && json is! Uint8List) {
      final asList = (json as List).cast<int>();
      return Uint8List.fromList(asList) as T;
    }

    // Fallback: intentar el cast directo
    try {
      return json as T;
    } catch (e) {
      // Si falla, retornar valor por defecto según el tipo
      return _getDefaultValue<T>();
    }
  }

  @override
  dynamic toJson<T>(T value) {
    if (value == null) return null;

    // Manejar List<String> específicamente
    if (value is List<String>) {
      return value;
    }

    // Comportamiento por defecto para otros tipos
    if (value is DateTime) {
      return value.toIso8601String();
    }

    if (value is Uint8List) {
      return value.toList();
    }

    return value;
  }
  T _getDefaultValue<T>() {
    final tString = T.toString();
    if (tString == 'List<String>' || tString == 'List<String>?') {
      return [] as T;
    }
    // Agregar más tipos según necesites
    return null as T;
  }
  }
