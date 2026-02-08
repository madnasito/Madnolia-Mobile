import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/invitation_model.dart';

import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/utils/images_util.dart';
import 'package:madnolia/utils/platforms.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/chat/chat_message_model.dart';
import '../models/connection/accepted_connection_model.dart';
import '../models/friendship/connection_request.dart';

@pragma("vm:entry-point")
class LocalNotificationsService {
  static final _userRepository = RepositoryManager().user;
  static final _chatMessageRepository = RepositoryManager().chatMessage;
  static final _matchRepository = RepositoryManager().match;
  static final _gamesRepository = RepositoryManager().games;
  static final talker = Talker();
  // Instance of Flutternotification plugin
  @pragma("vm:entry-point")
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool _launchNotificationProcessed = false;

  @pragma("vm:entry-point")
  static Future<void> initialize() async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
      description:
          'This channel is used for important notifications.', // description
    );

    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/launcher_icon"),
        );

    {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final version = androidInfo.version.sdkInt;
      debugPrint(version.toString());

      if (version > 32) {
        final androidPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        // Verificar si ya tenemos los permisos
        final bool granted =
            await androidPlugin?.areNotificationsEnabled() ?? false;

        if (!granted) {
          await androidPlugin?.requestNotificationsPermission();
        }
      }
    }

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    await _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // Manejar caso de Cold Start (App totalmente cerrada)
    // Solo procesar una vez por ejecución de la app
    if (_launchNotificationProcessed) return;

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      if (notificationAppLaunchDetails.notificationResponse != null) {
        _launchNotificationProcessed = true;
        // Un pequeño retraso para permitir que GoRouter inicialice y maneje el redirect inicial
        Future.delayed(const Duration(seconds: 2), () {
          onDidReceiveNotificationResponse(
            notificationAppLaunchDetails.notificationResponse!,
          );
        });
      }
    } else {
      // Si la app no fue lanzada por una notificación, marcamos como procesado igual
      // para evitar re-consultas innecesarias en cada rebuild de HomeUserPage
      _launchNotificationProcessed = true;
    }
  }

  static final List<List<ChatMessage>> _roomMessages =
      []; // Lista para almacenar mensajes

  @pragma("vm:entry-point")
  static Future<void> initializeTranslations() async {
    LocaleSettings.useDeviceLocale();
  }

  @pragma("vm:entry-point")
  static Future<void> displayRoomMessage(ChatMessage message) async {
    try {
      await initializeTranslations();
      const String groupChannelId = 'messages';
      const String groupChannelName = 'Messages';
      const String groupChannelDescription = 'Messages channel';
      const String groupKey = 'all_chat_messages'; // Clave de grupo unificada

      List<ChatMessage> targetGroup;
      int groupIndex = _roomMessages.indexWhere(
        (group) =>
            group.isNotEmpty &&
            group.first.conversation == message.conversation,
      );

      if (groupIndex != -1) {
        targetGroup = _roomMessages[groupIndex];
        targetGroup.add(message);
      } else {
        targetGroup = [message];
        _roomMessages.add(targetGroup);
      }

      int notificationId = message.conversation.hashCode;

      // --- LÓGICA DE TÍTULO Y DEPURACIÓN ---
      const storage = FlutterSecureStorage();
      final currentUserId = await storage.read(key: "userId");
      if (currentUserId == null) {
        debugPrint("Notification Error: currentUserId is null. Aborting.");
        return;
      }

      debugPrint("--- Notification Title Debug ---");
      debugPrint("Current User ID: $currentUserId");
      debugPrint("Incoming Message Creator ID: ${message.creator}");

      String? title;
      if (message.type == ChatMessageType.match) {
        title = (await _matchRepository.getMatchById(
          message.conversation,
        )).title;
        debugPrint("Message type is Match. Title: $title");
      } else {
        debugPrint("Message type is User. Calculating other user's name...");
        final otherUser = await _userRepository.getUserByFriendship(
          message.conversation,
        );
        title = otherUser?.name;
        debugPrint("Calculated Title (Other User's Name): $title");
      }
      debugPrint("--- End Notification Title Debug ---");
      // --- FIN LÓGICA DE TÍTULO ---

      final userIds = targetGroup.map((msg) => msg.creator).toSet();
      final userData = <String, UserData>{};
      for (final userId in userIds) {
        userData[userId] = await _userRepository.getUserById(userId);
      }

      final currentUserDb = await _userRepository.getUserById(currentUserId);
      final currentUserImage = await getRoundedImageBytes(
        CachedNetworkImageProvider(currentUserDb.thumb),
      );

      final Person me = Person(
        key: currentUserDb.id,
        name: t.UTILS.YOU,
        icon: ByteArrayAndroidIcon(currentUserImage),
      );

      List<Message> notiMessages = await Future.wait(
        targetGroup.map((msg) async {
          final user = userData[msg.creator]!;
          final image = await getRoundedImageBytes(
            CachedNetworkImageProvider(user.thumb),
          );
          return Message(
            msg.content,
            msg.date,
            Person(
              name: user.name,
              bot: false,
              icon: ByteArrayAndroidIcon(image),
              key: user.id,
            ),
          );
        }).toList(),
      );

      final lastSender = await _userRepository.getUserById(message.creator);
      final image = await getRoundedImageBytes(
        CachedNetworkImageProvider(lastSender.thumb),
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          groupKey: groupKey,
          setAsGroupSummary: false,
          importance: Importance.high,
          icon: '@drawable/ic_notifications',
          priority: Priority.high,
          category: AndroidNotificationCategory.message,
          colorized: true,
          largeIcon: ByteArrayAndroidBitmap(image),
          actions: [
            AndroidNotificationAction(
              message.id,
              t.FORM.INPUT.REPLY,
              inputs: [
                AndroidNotificationActionInput(
                  label: t.CHAT.MESSAGE,
                  allowFreeFormInput: true,
                ),
              ],
            ),
            AndroidNotificationAction(message.id, t.FORM.INPUT.MARK_AS_READ),
          ],
          styleInformation: MessagingStyleInformation(
            me,
            groupConversation: _roomMessages.length > 1,
            conversationTitle: title,
            messages: notiMessages,
          ),
        ),
      );

      await _notificationsPlugin.show(
        notificationId,
        null,
        null,
        notificationDetails,
        payload: chatMessageToJson(message),
      );

      if (_roomMessages.length > 1) {
        final int summaryId = -1;

        List<String> summaryLines = [];
        for (var group in _roomMessages) {
          if (group.isNotEmpty) {
            // Corrección: Asegurarse de obtener el título correcto para cada grupo en el resumen
            String? chatTitle;
            if (group.first.type == ChatMessageType.match) {
              chatTitle = (await _matchRepository.getMatchById(
                group.first.conversation,
              )).title;
            } else {
              final otherUserId = await _userRepository.getUserByFriendship(
                group.first.conversation,
              );
              chatTitle = otherUserId?.name;
            }
            summaryLines.add('${group.length} new message(s) in "$chatTitle"');
          }
        }

        final inboxStyleInformation = InboxStyleInformation(
          summaryLines,
          contentTitle: '${_roomMessages.length} chats with new messages',
          summaryText:
              '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
        );

        final notificationSummaryDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            groupChannelId,
            groupChannelName,
            channelDescription: groupChannelDescription,
            styleInformation: inboxStyleInformation,
            groupKey: groupKey,
            setAsGroupSummary: true,
            icon: '@drawable/ic_notifications',
          ),
        );

        await _notificationsPlugin.show(
          summaryId,
          '${_roomMessages.length} chats',
          '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
          notificationSummaryDetails,
        );
      }
    } catch (e) {
      debugPrint('Error en displayMessage: $e');
    }
  }

  @pragma("vm:entry-point")
  static Future<void> displayInvitation(Invitation invitation) async {
    // To display the notification in device

    try {
      LocaleSettings.useDeviceLocale();
      await initializeTranslations();
      final matchDb = await _matchRepository.getMatchById(invitation.match);
      final userDb = await _userRepository.getUserById(invitation.user);

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final detailsInfo = invitation.img != null
          ? invitationWithImage(
              invitation: invitation,
              matchData: matchDb,
              userDb: userDb,
            )
          : invitationWithoutImage(
              userDb: userDb,
              invitation: invitation,
              matchData: matchDb,
            );
      NotificationDetails notificationDetails = await detailsInfo;
      await _notificationsPlugin.show(
        id,
        null,
        null,
        notificationDetails,
        payload: json.encode(matchDb.toJson()),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @pragma("vm:entry-point")
  static Future<void> requestConnection(
    ConnectionRequest connectionRequest,
  ) async {
    // To display the notification in device

    try {
      LocaleSettings.useDeviceLocale();
      await initializeTranslations();
      final userDb = await _userRepository.getUserById(
        connectionRequest.sender,
      );

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final image = await getRoundedImageBytes(
        CachedNetworkImageProvider(userDb.thumb),
      );

      final detailsInfo = NotificationDetails(
        android: AndroidNotificationDetails(
          "main_channel",
          "Main Channel",
          groupKey: "connection_requests",
          playSound: true,
          icon: '@drawable/ic_notifications',
          subText: t.NOTIFICATIONS.CONNECTION_REQUEST_TITLE,
          largeIcon: ByteArrayAndroidBitmap(image),
          priority: Priority.high,
          importance: Importance.high,
        ),
      );
      NotificationDetails notificationDetails = detailsInfo;
      await _notificationsPlugin.show(
        id,
        t.NOTIFICATIONS.CONNECTION_REQUEST_TITLE,
        t.NOTIFICATIONS.CONNECTION_REQUEST(name: userDb.name),
        notificationDetails,
        payload: json.encode(connectionRequest.toJson()),
      );
    } catch (e) {
      talker.error(e);
      talker.handle(e);
      rethrow;
    }
  }

  static Future<NotificationDetails> requestAccepted(
    AcceptedConnection acceptedConnection,
  ) async {
    final userDb = await _userRepository.getUserById(
      acceptedConnection.request.receiver,
    );

    final image = await getRoundedImageBytes(
      CachedNetworkImageProvider(userDb.thumb),
    );
    final detailsInfo = NotificationDetails(
      android: AndroidNotificationDetails(
        "main_channel",
        "Main Channel",
        groupKey: "connection_requests",
        playSound: true,
        icon: '@drawable/ic_notifications',
        subText: t.NOTIFICATIONS.CONNECTION_ACCEPTED_TITLE,
        largeIcon: ByteArrayAndroidBitmap(image),
        priority: Priority.high,
        importance: Importance.high,
      ),
    );
    NotificationDetails notificationDetails = detailsInfo;
    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      t.NOTIFICATIONS.CONNECTION_ACCEPTED_TITLE,
      t.NOTIFICATIONS.CONNECTION_ACCEPTED(name: userDb.name),
      notificationDetails,
      payload: acceptedConnectionToJson(acceptedConnection),
    );
    return notificationDetails;
  }

  static Future<NotificationDetails> invitationWithImage({
    required UserData userDb,
    required Invitation invitation,
    required MatchData matchData,
  }) async {
    final image = await imageProviderToBase64(
      CachedNetworkImageProvider(resizeRawgImage(invitation.img!)),
    );
    final String platformName = getPlatformInfo(matchData.platform.id).name;
    final icon = ByteArrayAndroidBitmap.fromBase64String(image);
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "main_channel",
        "Main Channel",
        groupKey: "gfg",
        playSound: true,
        icon: '@drawable/ic_notifications',
        subText: t.NOTIFICATIONS.MATCH_INVITATION,
        styleInformation: BigPictureStyleInformation(
          icon,
          contentTitle:
              "${t.NOTIFICATIONS.INVITED_TO} ${invitation.name} | $platformName",
          summaryText: "@${userDb.username}",
        ),
        priority: Priority.high,
      ),
    );
  }

  static Future<NotificationDetails> invitationWithoutImage({
    required UserData userDb,
    required Invitation invitation,
    required MatchData matchData,
  }) async {
    final String platformName = getPlatformInfo(matchData.platform.id).name;
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "main_channel",
        "Main Channel",
        groupKey: "gfg",
        playSound: true,
        icon: '@drawable/ic_notifications',
        subText: t.NOTIFICATIONS.MATCH_INVITATION,
        styleInformation: BigTextStyleInformation(
          "${t.NOTIFICATIONS.INVITED_TO} ${invitation.name} | $platformName",
          summaryText: "@${userDb.username}",
        ),
      ),
    );
  }

  @pragma("vm:entry-point")
  static Future<void> displayMatchReady(MatchReady payload) async {
    // To display the notification in device
    await initializeTranslations();
    try {
      final matchDb = await _matchRepository.getMatchById(payload.match);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final gameDb = await _gamesRepository.getGameById(matchDb.game);
      final image = await imageProviderToBase64(
        CachedNetworkImageProvider(resizeRawgImage(gameDb.background!)),
      );
      final icon = ByteArrayAndroidBitmap.fromBase64String(image);

      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          icon: '@drawable/ic_notifications',
          "main_channel",
          "Main Channel",
          groupKey: "gfg",
          playSound: true,
          styleInformation: gameDb.background != null
              ? BigPictureStyleInformation(icon)
              : null,
          timeoutAfter: 1000 * 60 * 5,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(
        id,
        t.NOTIFICATIONS.MATCH_READY,
        t.NOTIFICATIONS.MATCH_STARTED(name: payload.title),
        notificationDetails,
        payload: json.encode(matchDb.toJson()),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @pragma("vm:entry-point")
  static void onDidReceiveNotificationResponse(
    NotificationResponse details,
  ) async {
    if (details.payload == null || details.payload!.isEmpty) {
      talker.info("Notification payload is empty.");
      return;
    }

    // _roomMessages.clear();
    // _userMessages.clear();

    try {
      MatchData matchDb = MatchData.fromJson(json.decode(details.payload!));
      router.push("/match/${matchDb.id}");
      return;
    } catch (e) {
      talker.debug("Not MatchData payload: $e");
    }

    try {
      ConnectionRequest.fromJson(json.decode(details.payload!));
      router.pushNamed("notifications");
      return;
    } catch (e) {
      talker.debug("Not ConnectionRequest payload: $e");
    }

    try {
      AcceptedConnection acceptedConnection = acceptedConnectionFromJson(
        details.payload!,
      );
      UserData userDb = await _userRepository.getUserById(
        acceptedConnection.request.receiver,
      );

      final ChatUser chatUser = ChatUser(
        id: userDb.id,
        name: userDb.name,
        thumb: userDb.thumb,
        username: userDb.username,
      );

      router.pushNamed("user-chat", extra: chatUser);
      return;
    } catch (e) {
      talker.debug("Not AcceptedConnection payload: $e");
    }

    try {
      final ChatMessage message = chatMessageFromJson(details.payload!);
      switch (message.type) {
        case ChatMessageType.user:
          UserData userDb = await _userRepository.getUserById(message.creator);
          const storage = FlutterSecureStorage();

          if (userDb.id == await storage.read(key: "userId")) {
            userDb =
                await _userRepository.getUserByFriendship(
                  message.conversation,
                ) ??
                userDb;
          }

          final ChatUser chatUser = ChatUser(
            id: userDb.id,
            name: userDb.name,
            thumb: userDb.thumb,
            username: userDb.username,
          );
          router.pushNamed("user-chat", extra: chatUser);
          break;
        default:
          router.push("/match/${message.conversation}");
      }
    } catch (e) {
      talker.handle(e);
      rethrow;
    }
  }

  @pragma("vm:entry-point")
  static Future<void> deleteRoomMessages(String room) async {
    try {
      debugPrint('Delete messages of room $room');

      // 1. Eliminar de la lista en memoria
      _roomMessages.removeWhere(
        (group) => group.isNotEmpty && group.first.conversation == room,
      );

      // 2. Obtener ID específico para esta sala
      int roomNotificationId = room.hashCode;

      // 3. Cancelar solo la notificación específica de esta sala
      await _notificationsPlugin.cancel(roomNotificationId);

      // 4. Si hay más de un grupo activo, actualizar el resumen
      if (_roomMessages.length > 1) {
        await _updateSummaryNotification();
      } else {
        // 5. Si queda 1 o 0, ya no se necesita un resumen.
        // Si queda 1, su notificación individual ya está visible.
        await _notificationsPlugin.cancel(-1); // ID del resumen
      }

      debugPrint('Notificaciones eliminadas para la sala: $room');
    } catch (e) {
      debugPrint('Error al eliminar notificaciones: $e');
    }
  }

  // Método auxiliar para actualizar el resumen
  static Future<void> _updateSummaryNotification() async {
    try {
      const storage = FlutterSecureStorage();
      final currentUserId = await storage.read(key: "userId");
      if (currentUserId == null) return;

      const String groupChannelId = 'messages';
      const String groupChannelName = 'Messages';
      const String groupChannelDescription = 'Messages channel';
      const String groupKey = 'all_chat_messages';

      List<String> summaryLines = [];
      for (var group in _roomMessages) {
        if (group.isNotEmpty) {
          String? chatTitle;
          if (group.first.type == ChatMessageType.match) {
            chatTitle = (await _matchRepository.getMatchById(
              group.first.conversation,
            )).title;
          } else {
            final otherUserId = await _userRepository.getUserByFriendship(
              group.first.conversation,
            );
            chatTitle = otherUserId?.name;
          }
          summaryLines.add('${group.length} new message(s) in "$chatTitle"');
        }
      }

      final inboxStyleInformation = InboxStyleInformation(
        summaryLines,
        contentTitle: '${_roomMessages.length} chats with new messages',
        summaryText:
            '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
      );

      final notificationSummaryDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          styleInformation: inboxStyleInformation,
          groupKey: groupKey,
          setAsGroupSummary: true,
          icon: '@drawable/ic_notifications',
        ),
      );

      await _notificationsPlugin.show(
        -1, // ID fijo para el resumen
        '${_roomMessages.length} chats',
        '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
        notificationSummaryDetails,
      );
    } catch (e) {
      debugPrint('Error updating summary: $e');
    }
  }

  @pragma("vm:entry-point")
  static Future<void> notificationTapBackground(
    NotificationResponse notificationResponse,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    if (notificationResponse.input != null) {
      try {
        debugPrint('Notification response: ${notificationResponse.payload}');
        if (kDebugMode) {
          await dotenv.load(fileName: "assets/.env.dev");
        } else {
          await dotenv.load(fileName: "assets/.env.prod");
        }

        await initializeTranslations();
        final message = chatMessageFromJson(notificationResponse.payload!);
        final backgroundService = FlutterBackgroundService();
        final isRunning = await backgroundService.isRunning();

        final uuid = Uuid();

        final String id = uuid.v4();

        final storage = FlutterSecureStorage();

        final userId = await storage.read(key: "userId");

        debugPrint('User ID: $userId');

        debugPrint('Background running: $isRunning');

        if (!isRunning) {
          await _chatMessageRepository.createOrUpdate(
            ChatMessageCompanion(
              id: Value(id),
              creator: Value(userId!),
              conversation: Value(message.conversation),
              content: Value(notificationResponse.input.toString()),
              type: Value(message.type),
              date: Value(DateTime.now()),
              status: Value(ChatMessageStatus.sent),
              pending: Value(true),
            ),
          );
          Timer(Duration(milliseconds: 100), startBackgroundService);
        } else {
          final newMessage = CreateMessage(
            id: id,
            conversation: message.conversation,
            content: notificationResponse.input.toString(),
            type: message.type,
          );
          backgroundService.invoke('new_message', newMessage.toJson());
        }
      } catch (e) {
        debugPrint("Error in notificationTapBackground: $e");
      }
    }
  }

  @pragma("vm:entry-point")
  static Future<void> deleteAllNotifications() async {
    try {
      // 1. Limpiar listas en memoria
      _roomMessages.clear();
      // _userMessages.clear();

      // 2. Cancelar todas las notificaciones activas
      final activeNotifications = await _notificationsPlugin
          .getActiveNotifications();

      for (final notification in activeNotifications) {
        await _notificationsPlugin.cancel(notification.id!);
      }

      // // 3. Cancelar cualquier notificación pendiente
      // await _notificationsPlugin.cancelAll();

      debugPrint('Todas las notificaciones fueron eliminadas');
    } catch (e) {
      debugPrint('Error al eliminar todas las notificaciones: $e');
    }
  }
}
