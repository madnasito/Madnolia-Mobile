import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/conversations/conversation_state_repository.dart';
import 'package:madnolia/database/users/user_repository.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';

import '../../models/chat/chat_message_model.dart';
import '../../services/messages_service.dart';

class ChatMessageRepository {

  final database = AppDatabase();
  final _conversationRepository = ConversationRepository();

  final _messagesService = MessagesService();
  final _userRepository = UserRepository();

  Future<int> createOrUpdate(ChatMessageCompanion message) async {
    try {
      // Verify that user creator exists
      await _userRepository.getUserById(message.creator.value);
      
      return await database.into(database.chatMessage).insertOnConflictUpdate(message);
    } catch (e) {
      debugPrint('Error in create or update message: $e');
      rethrow;
    }
  }

  Future<void> createOrUpdateMultiple(List<ChatMessageCompanion> messages) async {
    try {

      final List<String> creators = messages.map((m) => m.creator.value).toList();

      // Verifying all messages creators below
      await _userRepository.getUsersByIds(creators);

      await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.chatMessage, messages);
      });
      // Notificar actualización manualmente
      database.notifyUpdates({const TableUpdate('chat_message', kind: UpdateKind.insert)});
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

  Future<int> updateMessageContent(String messageId, String content) async {
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

  Future<List<ChatMessageData>> getMessagesInRoom({ required String conversationId, required ChatMessageType type, String? cursorId}) async {
    try {
      final query = database.select(database.chatMessage)
        ..where((tbl) => tbl.conversation.equals(conversationId));

      if (cursorId != null) {
        final cursorMessage = await (database.select(database.chatMessage)..where((tbl) => tbl.id.equals(cursorId))).getSingleOrNull();
        if (cursorMessage != null) {
          query.where((tbl) => tbl.date.isSmallerThan(Variable(cursorMessage.date)));
        }
      }

      final messages = await (query
        ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
        ..limit(50)
      ).get();

      if (messages.length < 50) {

        final conversationExists = await _conversationRepository.get(conversationId);

        if(conversationExists != null && conversationExists.hasReachedEnd) return messages;

        List<ChatMessage> messagesApi = [];
        switch (type) {
          case ChatMessageType.match:
              messagesApi = await _messagesService.getMatchMessages(conversationId, cursorId);
          case ChatMessageType.user:
              messagesApi = await _messagesService.getUserChatMessages(conversationId, cursorId);
            break;
          default:
        }

        if (messagesApi.isNotEmpty) {
          final messageCompanions = messagesApi.map((m) => m.toCompanion()).toList();
          await createOrUpdateMultiple(messageCompanions);

          final newMessages = messagesApi.map((m) => ChatMessageData(
            id: m.id,
            status: m.status,
            content: m.content,
            conversation: m.conversation,
            creator: m.creator,
            date: m.date,
            updatedAt: m.updatedAt,
            type: m.type
          )).toList();
          messages.addAll(newMessages);
        }

        if(messagesApi.length < 50) {
          await _conversationRepository.createOrUpdate(
            ConversationCompanion(
              conversationId: Value(conversationId),
              hasReachedEnd: Value(true),
            ),
          );
        }

        
      }
            return messages;
          } catch (e) {
            rethrow;
          }
        }
      
  Stream<List<ChatMessageData>> watchMessagesInRoom({ required String conversationId, int limit = 50, String? cursorId}) async* {
    try {
      final query = database.select(database.chatMessage)
        ..where((tbl) => tbl.conversation.equals(conversationId));

      if (cursorId != null) {
        final cursorMessage = await (database.select(database.chatMessage, distinct: true)
          ..where((tbl) => tbl.id.equals(cursorId))).getSingleOrNull();
        if (cursorMessage != null) {
          query.where((tbl) => tbl.date.isSmallerThan(Variable(cursorMessage.date)));
        }
      }

      final finalQuery = query
        ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])
        ..limit(limit);

      yield* finalQuery.watch().map((messages) {
        debugPrint('watchMessagesInRoom: cambio detectado, mensajes: ${messages.length}');
        return messages;
      });
    } catch (e) {
      rethrow;
    }
  }
}
      