import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/conversations/conversation_state_repository.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/users/user_repository.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/chat_message_with_user.dart';

import '../../models/chat/chat_message_model.dart';
import '../../services/messages_service.dart';

class ChatMessageRepository {

  final AppDatabase database;
  late final ConversationRepository _conversationRepository;

  final _messagesService = MessagesService();
  late final UserRepository _userRepository;

  ChatMessageRepository(this.database) {
    _conversationRepository = ConversationRepository(database);
    _userRepository = UserRepository(database);
  }

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
          pending: Value(false)
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

      debugPrint('Getting messages in room');
      debugPrint('Messages type: $type');
      debugPrint('Cursor: $cursorId');

      final query = database.select(database.chatMessage)
        ..where((tbl) => tbl.conversation.equals(conversationId));

      if (cursorId != null) {
        debugPrint('Searching for cursor message with id: $cursorId');
        final cursorMessage = await (database.select(database.chatMessage)..where((tbl) => tbl.id.equals(cursorId))).getSingleOrNull();
        if (cursorMessage != null) {
          debugPrint('Cursor message found: ${cursorMessage.id} with date ${cursorMessage.date}');
          query.where((tbl) => tbl.date.isSmallerThan(Variable(cursorMessage.date)));        
          debugPrint('Query: messages BEFORE ${cursorMessage.date}');

        } else {
          debugPrint('Cursor message with id $cursorId not found in local database');
        }
      }

      final messages = await (query
        ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
        ..limit(50)
      ).get();

      debugPrint('Messages length: ${messages.length}');

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

        debugPrint(messagesApi.length.toString());

        for (var message in messagesApi) {
          debugPrint(message.content);
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
            type: m.type,
            pending: false
          )).toList();
          messages.addAll(newMessages);
        }

        if(messagesApi.isEmpty) {
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
      
  Stream<List<ChatMessageWithUser>> watchMessagesInRoom({ required String conversationId}) async* {
    try {
      final query = database.select(database.chatMessage).join([
        innerJoin(database.user, database.user.id.equalsExp(database.chatMessage.creator))
      ])
      ..where(database.chatMessage.conversation.equals(conversationId));
     
      query.orderBy([
        OrderingTerm.desc(database.chatMessage.date),
        OrderingTerm.desc(database.chatMessage.id),
      ]);

      yield* query.watch().map((rows) {
        return rows.map((row) {
          return ChatMessageWithUser(
            chatMessage: row.readTable(database.chatMessage), 
            user: row.readTable(database.user)
          );
        }).toList();
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
      