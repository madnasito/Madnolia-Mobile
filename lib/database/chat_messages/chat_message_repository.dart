import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';

import '../../services/messages_service.dart';

class ChatMessageRepository {

  final database = AppDatabase.instance;

  final _messagesService = MessagesService();

  Future<int> createOrUpdate(ChatMessageCompanion message) async {
    try {
      return await database.into(database.chatMessage).insertOnConflictUpdate(message);
    } catch (e) {
      debugPrint('Error in create or update message: $e');
      rethrow;
    }
  }

  Future<void> createOrUpdateMultiple(List<ChatMessageCompanion> messages) async {
    try {
      return await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.chatMessage, messages);
      });
    } catch (e) {
      debugPrint('Error in create or update multiple messages: $e');
      rethrow;
    }
  }

  Future<int> messageSended(String oldId, String newId, DateTime date) async {
    try {
      return await (database.update(database.chatMessage)..where((tbl) => tbl.id.equals(oldId))).write(
        ChatMessageCompanion(
          id: Value(newId),
          date: Value(date),
          status: Value(ChatMessageStatus.sent),
        ),
      );
    } catch (e) {
      debugPrint('Error in updateMessageId: $e');
      rethrow;
    }
  }

  Future<int> updateMessageStatus(String messageId, ChatMessageStatus status) async {
    try {
      return await (database.update(database.chatMessage)..where((tbl) => tbl.id.equals(messageId))).write(
        ChatMessageCompanion(
          status: Value(status),
        ),
      );
    } catch (e) {
      debugPrint('Error in updateMessageStatus: $e');
      rethrow;
    }
  }

  Future<int> updateMessage(String messageId, String content) async {
    try {
      return await (database.update(database.chatMessage)..where((tbl) => tbl.id.equals(messageId))).write(
        ChatMessageCompanion(
          content: Value(content),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      debugPrint('Error in updateMessage: $e');
      rethrow;
    }
  }

  Future<int> deleteMessages() async {
    try {
      return await database.managers.chatMessage.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteMessagesInRoom(String conversationId) async {
    try {
      return await (database.delete(database.chatMessage)..where((tbl) => tbl.conversation.equals(conversationId))).go();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatMessageData>> getMessagesInRoom({ required String conversationId, int skip = 0}) async {
    try {
      return await (database.select(database.chatMessage)
        ..where((tbl) => tbl.conversation.equals(conversationId))
        ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
        ..limit(30, offset: skip)
      ).get();
    } catch (e) {
      rethrow;
    }
  }
}