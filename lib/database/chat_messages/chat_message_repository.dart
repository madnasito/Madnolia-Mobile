import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/database/conversations/conversation_state_repository.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/friendships/frienship.repository.dart';
import 'package:madnolia/database/users/user_repository.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/chat_message_with_user.dart';
import 'package:madnolia/models/chat/user_chat.dart';

import '../../models/chat/chat_message_model.dart';
import '../../services/messages_service.dart';

class ChatMessageRepository {
  final AppDatabase database;
  late final ConversationRepository _conversationRepository;

  final _messagesService = MessagesService();
  late final UserRepository _userRepository;
  late final FriendshipRepository _friendshipRepository;

  ChatMessageRepository(this.database) {
    _conversationRepository = ConversationRepository(database);
    _userRepository = UserRepository(database);
    _friendshipRepository = FriendshipRepository(database);
  }

  Future<int> createOrUpdate(ChatMessageCompanion message) async {
    try {
      // Verify that user creator exists
      await _userRepository.getUserById(message.creator.value);

      return await database
          .into(database.chatMessage)
          .insertOnConflictUpdate(message);
    } catch (e) {
      debugPrint('Error in create or update message: $e');
      rethrow;
    }
  }

  Future<void> createOrUpdateMultiple(
    List<ChatMessageCompanion> messages,
  ) async {
    try {
      final List<String> creators = messages
          .map((m) => m.creator.value)
          .toList();

      // Verifying all messages creators below
      await _userRepository.getUsersByIds(creators);

      await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.chatMessage, messages);
      });
      // Notificar actualización manualmente
      database.notifyUpdates({
        const TableUpdate('chat_message', kind: UpdateKind.insert),
      });
    } catch (e) {
      debugPrint('Error in create or update multiple messages: $e');
      rethrow;
    }
  }

  Future<List<ChatMessageData>> getAllSentMessages() async {
    try {
      final query = database.select(database.chatMessage)
        ..where(
          (tbl) =>
              tbl.status.equals(ChatMessageStatus.sent.index) &
              tbl.pending.equals(true),
        );

      final messages =
          await (query..orderBy([
                (t) =>
                    OrderingTerm(expression: t.date, mode: OrderingMode.desc),
              ]))
              .get();

      return messages;
    } catch (e) {
      debugPrint('Error getting sent messages:');
      rethrow;
    }
  }

  Future<int> messageSended(String oldId, String newId, DateTime date) async {
    try {
      return await (database.update(
        database.chatMessage,
      )..where((tbl) => tbl.id.equals(oldId))).write(
        ChatMessageCompanion(
          id: Value(newId),
          date: Value(date),
          status: Value(ChatMessageStatus.delivered),
          pending: Value(false),
        ),
      );
    } catch (e) {
      debugPrint('Error in updateMessageId: $e');
      rethrow;
    }
  }

  Future<int> updateMessageStatus(
    String messageId,
    ChatMessageStatus status,
  ) async {
    try {
      return await (database.update(database.chatMessage)
            ..where((tbl) => tbl.id.equals(messageId)))
          .write(ChatMessageCompanion(status: Value(status)));
    } catch (e) {
      debugPrint('Error in updateMessageStatus: $e');
      rethrow;
    }
  }

  Future<int> updateMessageContent(String messageId, String content) async {
    try {
      return await (database.update(
        database.chatMessage,
      )..where((tbl) => tbl.id.equals(messageId))).write(
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
      return await (database.delete(
        database.chatMessage,
      )..where((tbl) => tbl.conversation.equals(conversationId))).go();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatMessageData>> getMessagesInRoom({
    required String conversationId,
    required ChatMessageType type,
    String? cursorId,
  }) async {
    try {
      debugPrint('Getting messages in room');
      debugPrint('Messages type: $type');
      debugPrint('Cursor: $cursorId');

      final query = database.select(database.chatMessage)
        ..where((tbl) => tbl.conversation.equals(conversationId));

      if (cursorId != null) {
        debugPrint('Searching for cursor message with id: $cursorId');
        final cursorMessage = await (database.select(
          database.chatMessage,
        )..where((tbl) => tbl.id.equals(cursorId))).getSingleOrNull();
        if (cursorMessage != null) {
          debugPrint(
            'Cursor message found: ${cursorMessage.id} with date ${cursorMessage.date}',
          );
          query.where(
            (tbl) => tbl.date.isSmallerThan(Variable(cursorMessage.date)),
          );
          debugPrint('Query: messages BEFORE ${cursorMessage.date}');
        } else {
          debugPrint(
            'Cursor message with id $cursorId not found in local database',
          );
        }
      }

      final messages =
          await (query
                ..orderBy([
                  (t) =>
                      OrderingTerm(expression: t.date, mode: OrderingMode.desc),
                ])
                ..limit(50))
              .get();

      debugPrint('Messages length: ${messages.length}');

      if (messages.length < 50) {
        final conversationExists = await _conversationRepository.get(
          conversationId,
        );

        if (conversationExists != null && conversationExists.hasReachedEnd) {
          return messages;
        }

        List<ChatMessage> messagesApi = [];
        switch (type) {
          case ChatMessageType.match:
            messagesApi = await _messagesService.getMatchMessages(
              conversationId,
              cursorId,
            );
          case ChatMessageType.user:
            messagesApi = await _messagesService.getUserChatMessages(
              conversationId,
              cursorId,
            );
            break;
          default:
        }

        debugPrint(messagesApi.length.toString());

        for (var message in messagesApi) {
          debugPrint(message.content);
        }

        if (messagesApi.isNotEmpty) {
          final messageCompanions = messagesApi
              .map((m) => m.toCompanion())
              .toList();
          await createOrUpdateMultiple(messageCompanions);

          final newMessages = messagesApi
              .map(
                (m) => ChatMessageData(
                  id: m.id,
                  status: m.status,
                  content: m.content,
                  conversation: m.conversation,
                  creator: m.creator,
                  date: m.date,
                  updatedAt: m.updatedAt,
                  type: m.type,
                  pending: false,
                ),
              )
              .toList();
          messages.addAll(newMessages);
        }

        if (messagesApi.isEmpty) {
          await _conversationRepository.createOrUpdate(
            ConversationCompanion(
              id: Value(conversationId),
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

  Future<void> syncFromDate(DateTime date) async {
    try {
      final lastMessageList =
          await (database.select(database.chatMessage)
                ..orderBy([
                  (t) =>
                      OrderingTerm(expression: t.date, mode: OrderingMode.desc),
                ])
                ..limit(1))
              .get();
      final lastMessage = lastMessageList.isNotEmpty
          ? lastMessageList.first
          : null;

      if (lastMessage == null) return;

      final messages = await _messagesService.syncFromDate(
        date: lastMessage.date.toUtc(),
      );

      if (messages.isNotEmpty) {
        final messageCompanions = messages.map((m) => m.toCompanion()).toList();
        await createOrUpdateMultiple(messageCompanions);
      }

      // Sync messages untill it is done
      if (messages.length == 50) {
        syncFromDate(messages.last.date.toUtc());
      } else {
        await FlutterSecureStorage().write(key: 'lastSyncDate', value: '');
      }
    } catch (e) {
      debugPrint('Error in sync: $e');
      rethrow;
    }
  }

  Future<List<UserChat>> getUsersChats({
    required int skip,
    bool reload = false,
  }) async {
    try {
      if (reload) {
        final apiChats = await MessagesService().getUsersChats(skip);

        final List<String> conversationIds = apiChats
            .map((e) => e.message.conversation)
            .toList();

        await _friendshipRepository.getFriendshipsByIds(
          ids: conversationIds,
          reload: true,
        );

        final List<ChatMessage> apiMessages = apiChats
            .map((e) => e.message)
            .toList();
        final messageCompanions = apiMessages
            .map((m) => m.toCompanion())
            .toList();
        await createOrUpdateMultiple(messageCompanions);
      }

      final query = database.select(database.chatMessage)
        ..where((tbl) => tbl.type.equals(ChatMessageType.user.index));

      final allMessages = await query.get();

      final groupedMessages = groupBy(allMessages, (m) => m.conversation);

      final latestMessages = groupedMessages.values.map((messages) {
        messages.sort((a, b) => b.date.compareTo(a.date));
        return messages.first;
      }).toList();

      latestMessages.sort((a, b) => b.date.compareTo(a.date));

      final userChats = await Future.wait(
        latestMessages.map((message) async {
          final friendship = await _friendshipRepository.getFriendshipById(
            message.conversation,
          );
          final user = await _userRepository.getUserById(friendship.user);
          final conversation = await _conversationRepository.get(
            message.conversation,
          );
          return UserChat(
            user: user,
            unreadCount: conversation?.unreadCount ?? 0,
            message: message,
          );
        }),
      );

      return userChats;
    } catch (e) {
      debugPrint(e.toString());

      rethrow;
    }
  }

  Stream<List<ChatMessageWithUser>> watchMessagesInRoom({
    required String conversationId,
  }) async* {
    try {
      final query = database.select(database.chatMessage).join([
        innerJoin(
          database.user,
          database.user.id.equalsExp(database.chatMessage.creator),
        ),
      ])..where(database.chatMessage.conversation.equals(conversationId));

      query.orderBy([
        OrderingTerm.desc(database.chatMessage.date),
        OrderingTerm.desc(database.chatMessage.id),
      ]);

      yield* query.watch().map((rows) {
        return rows.map((row) {
          return ChatMessageWithUser(
            chatMessage: row.readTable(database.chatMessage),
            user: row.readTable(database.user),
          );
        }).toList();
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // ...existing code...
  Stream<List<UserChat>> watchUserChats() {
    try {
      // Primero obtenemos por cada conversación la fecha máxima (último mensaje)
      final groupedQuery = (database.selectOnly(database.chatMessage)
        ..addColumns([
          database.chatMessage.conversation,
          database.chatMessage.date.max(),
        ])
        ..where(database.chatMessage.type.equals(ChatMessageType.user.index))
        ..groupBy([database.chatMessage.conversation]));

      return groupedQuery.watch().asyncMap((rows) async {
        // rows: cada fila contiene conversation + max(date)
        final convDates = <MapEntry<String, DateTime>>[];
        for (final row in rows) {
          final conv = row.read(database.chatMessage.conversation) as String;
          final maxDate = row.read(database.chatMessage.date.max()) as DateTime;
          convDates.add(MapEntry(conv, maxDate));
        }

        // Por cada (conversation, maxDate) obtenemos el ChatMessageData completo
        final latestMessages = <ChatMessageData>[];
        for (final e in convDates) {
          final msg =
              await (database.select(database.chatMessage)
                    ..where(
                      (t) =>
                          t.conversation.equals(e.key) & t.date.equals(e.value),
                    )
                    ..orderBy([
                      (t) => OrderingTerm.desc(t.date),
                    ]) // Asegúrate de ordenar
                    ..limit(1)) // Limitar a 1 resultado
                  .getSingleOrNull(); // Cambia a getSingleOrNull() para evitar el error
          if (msg != null) latestMessages.add(msg);
        }

        // Ordenar por fecha descendente y construir UserChat
        latestMessages.sort((a, b) => b.date.compareTo(a.date));
        final userChats = <UserChat>[];
        for (final lastMessage in latestMessages) {
          try {
            final friendship = await _friendshipRepository.getFriendshipById(
              lastMessage.conversation,
            );
            final user = await _userRepository.getUserById(friendship.user);
            final conversation = await _conversationRepository.get(
              lastMessage.conversation,
            );

            userChats.add(
              UserChat(
                user: user,
                unreadCount: conversation?.unreadCount ?? 0,
                message: lastMessage,
              ),
            );
          } catch (e) {
            debugPrint(
              'watchUserChats: error procesando ${lastMessage.conversation}: $e',
            );
          }
        }

        return userChats;
      });
    } catch (e) {
      debugPrint('Error in watchUserChats: $e');
      rethrow;
    }
  }
}
