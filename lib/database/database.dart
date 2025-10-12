import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/notifications_config/notifications_config.schema.dart';
import 'package:madnolia/database/users/user.schema.dart';
import 'package:madnolia/database/friendships/friendship.schema.dart';
import 'package:madnolia/database/match/match.schema.dart';
import 'package:madnolia/database/conversations/conversation.schema.dart';

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

@DriftDatabase(tables: [User, Friendship, Match, ChatMessage, Attachment, Game, Notification, NotificationsConfig, Conversation])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  
  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Puedes descomentar y usar este método si quieres una conexión por defecto:
  static QueryExecutor _openConnection() {
    debugPrint('database connected');
    return driftDatabase(
      name: 'madnolia',
      native: const DriftNativeOptions(
        shareAcrossIsolates: false,
        isolateDebugLog: true,
      ),
    );
  }
}