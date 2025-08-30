
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/invitation_model.dart';

import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/database/providers/match_db.dart';
import 'package:madnolia/database/providers/user_db.dart' show UserDb;
import 'package:madnolia/services/friendship_service.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/utils/images_util.dart';
import 'package:madnolia/utils/match_db_util.dart' show getMatchDb;
import 'package:madnolia/database/services/user-db.service.dart' show getUserDb;
import 'package:madnolia/widgets/atoms/game_image_atom.dart';
import '../models/chat/message_model.dart';


@pragma("vm:entry-point")
class LocalNotificationsService {
   // Instance of Flutternotification plugin
   @pragma("vm:entry-point")
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @pragma("vm:entry-point")
  static Future<void> initialize() async {
      const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher")
        );

     {
          final androidPlugin = _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
          
          // Verificar si ya tenemos los permisos
          final bool granted = await androidPlugin?.areNotificationsEnabled() ?? false;
          
          if (!granted) {
            await androidPlugin?.requestNotificationsPermission();
          }
      }

        
      _notificationsPlugin.initialize(
        initializationSettingsAndroid,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        // to handle event when we receive notification 
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );

  }

  static final List<List<ChatMessage>> _roomMessages = []; // Lista para almacenar mensajes  
  
  @pragma("vm:entry-point")
  static Future<void> initializeTranslations() async {
      // Use PlatformDispatcher to get the device locale
    Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio > 1.0 
        ? const Locale('en') // Fallback if needed
        : const Locale('en'); // Replace with actual logic to get locale

    String langCode = deviceLocale.languageCode;

    List<String> supportedLangs = ['en', 'es'];

    await LocalizationDelegate.create(
      fallbackLocale: supportedLangs.contains(langCode) ? langCode : 'en',
      supportedLocales: supportedLangs,
    );
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
      int groupIndex = _roomMessages.indexWhere((group) => 
          group.isNotEmpty && group.first.conversation == message.conversation);

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
      if (message.type == MessageType.match) {
        title = (await getMatchDb(message.conversation))?.title;
        debugPrint("Message type is Match. Title: $title");
      } else {
        debugPrint("Message type is User. Calculating other user's name...");
        final friendship = await FriendshipService().getFriendshipById(message.conversation);
        final otherUserId = friendship.user1 == currentUserId ? friendship.user2 : friendship.user1;
        debugPrint("Found Other User ID: $otherUserId");
        final otherUser = await getUserDb(otherUserId);
        title = otherUser.name;
        debugPrint("Calculated Title (Other User's Name): $title");
      }
      debugPrint("--- End Notification Title Debug ---");
      // --- FIN LÓGICA DE TÍTULO ---

      final userIds = targetGroup.map((msg) => msg.creator).toSet();
      final userData = <String, UserDb>{};
      for (final userId in userIds) {
        userData[userId] = await getUserDb(userId);
      }

      final currentUserDb = await getUserDb(currentUserId);
      final currentUserImage = await getRoundedImageBytes(CachedNetworkImageProvider(currentUserDb.thumb));

      final Person me = Person(
        key: currentUserDb.id,
        name: translate("UTILS.YOU"),
        icon: ByteArrayAndroidIcon(currentUserImage),
      );

      List<Message> notiMessages = await Future.wait(targetGroup.map((msg) async {
        final user = userData[msg.creator]!;
        final image = await getRoundedImageBytes(CachedNetworkImageProvider(user.thumb));
        return Message(
          msg.text,
          msg.date,
          Person(
            name: user.name,
            bot: false,
            icon: ByteArrayAndroidIcon(image),
            key: user.id
          )
        );
      }).toList());

      final lastSender = await getUserDb(message.creator);
      final image = await getRoundedImageBytes(CachedNetworkImageProvider(lastSender.thumb));
      
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          groupKey: groupKey,
          setAsGroupSummary: false,
          importance: Importance.high,
          icon: 'ic_notifications',
          priority: Priority.high,
          category: AndroidNotificationCategory.message,
          colorized: true,
          largeIcon: ByteArrayAndroidBitmap(image),
          actions: [
            AndroidNotificationAction(
              message.id,
              translate("FORM.INPUT.REPLY"),
              inputs: [AndroidNotificationActionInput(label: translate("CHAT.MESSAGE"), allowFreeFormInput: true)],
            ),
            AndroidNotificationAction(
              message.id,
              translate("FORM.INPUT.MARK_AS_READ"),
            )
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
            if (group.first.type == MessageType.match) {
              chatTitle = (await getMatchDb(group.first.conversation))?.title ?? 'Match';
            } else {
              final friendship = await FriendshipService().getFriendshipById(group.first.conversation);
              final otherUserId = friendship.user1 == currentUserId ? friendship.user2 : friendship.user1;
              chatTitle = (await getUserDb(otherUserId)).name;
            }
            summaryLines.add('${group.length} new message(s) in "$chatTitle"');
          }
        }

        final inboxStyleInformation = InboxStyleInformation(
          summaryLines,
          contentTitle: '${_roomMessages.length} chats with new messages',
          summaryText: '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
        );

        final notificationSummaryDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            groupChannelId, 
            groupChannelName,
            channelDescription: groupChannelDescription,
            styleInformation: inboxStyleInformation,
            groupKey: groupKey,
            setAsGroupSummary: true,
            icon: 'ic_notifications',
          ),
        );
        
        await _notificationsPlugin.show(
          summaryId,
          '${_roomMessages.length} chats',
          '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
          notificationSummaryDetails
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

      await initializeTranslations();
      final matchDb = await getMatchDb(invitation.match);
      final userDb = await getUserDb(invitation.user);
      final image = await imageProviderToBase64(CachedNetworkImageProvider(resizeImage(invitation.img)));
      final icon = ByteArrayAndroidBitmap.fromBase64String(image);
      
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails =  NotificationDetails(
        android: AndroidNotificationDetails(
            "Channel Id",
            "Main Channel",
            groupKey: "gfg",          
            playSound: true, 
            icon: 'ic_notifications',
            subText: translate("NOTIFICATIONS.MATCH_INVITATION"),
            styleInformation: BigPictureStyleInformation(
              icon,
              contentTitle: "${translate('NOTIFICATIONS.INVITED_TO')} ${invitation.name}",
              summaryText: "@${userDb.username}",
            ),
            // styleInformation: BigPictureStyleInformation(bigPicture),
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, null, null, notificationDetails, payload: matchDb?.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @pragma("vm:entry-point")
  static Future<void> displayMatchReady(MatchReady payload) async {
    // To display the notification in device
    await initializeTranslations();
    try {
      final matchDb = await getMatchDb(payload.match);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            icon: 'ic_notifications',
            "Channel Id",
            "Main Channel",
            groupKey: "gfg",
            playSound: true,
            timeoutAfter: 1000 * 60 * 5,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(
        id, translate('NOTIFICATIONS.MATCH_READY'),
        translate('NOTIFICATIONS.MATCH_STARTED', args: {'name': payload.title}),
        notificationDetails,
        payload: matchDb?.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @pragma("vm:entry-point")
  static void onDidReceiveNotificationResponse(NotificationResponse details) async {

      // _roomMessages.clear();
      // _userMessages.clear();
      try {
        MinimalMatchDb matchDb = MinimalMatchDb.fromJson(details.payload!);
        final context = navigatorKey.currentContext;
        GoRouter.of(context!).push("/match/${matchDb.id}");
      } catch (e) {
        debugPrint(e.toString());
      }

      try {
        final ChatMessage message = chatMessageFromJson(details.payload!);
        final context = navigatorKey.currentContext;
        switch (message.type) {
          case MessageType.user:
            UserDb userDb = await getUserDb(message.creator);
            const storage = FlutterSecureStorage();

            if(userDb.id == await storage.read(key: "userId")) {
              final friendship = await FriendshipService().getFriendshipById(message.conversation);
              userDb = await getUserDb(friendship.user1 == userDb.id ? friendship.user2 : friendship.user1);
            }
            
            final ChatUser chatUser = ChatUser(id: userDb.id, name: userDb.name, thumb: userDb.thumb, username: userDb.username);
            if(context!.mounted) GoRouter.of(context).pushNamed("user-chat", extra: chatUser);
            break;
          default:
             GoRouter.of(context!).push("/match/${message.conversation}");

        }
      } catch (e) {
        debugPrint(e.toString());
      }
  }

  @pragma("vm:entry-point")
  static Future<void> deleteRoomMessages(String room) async {
    try {
      debugPrint('Delete messages of room $room');
      // 1. Eliminar de la lista en memoria
      _roomMessages.removeWhere((group) => group.isNotEmpty && group[0].conversation == room);
      
      // 2. Cancelar todas las notificaciones del grupo
      final activeMessages = await _notificationsPlugin.getActiveNotifications();

      // Only log if there are active messages to avoid spam
      if (activeMessages.isNotEmpty) {
        debugPrint('Found ${activeMessages.length} active notifications');
      }
      
      for (final notification in activeMessages) {
        // Cancelar tanto mensajes individuales como el resumen
        if (notification.channelId == 'messages') {
          await _notificationsPlugin.cancel(notification.id!);
        }
      }
      
      // 3. Cancelar específicamente la notificación de resumen
      await _notificationsPlugin.cancel(0); // ID usado para el resumen
      
      debugPrint('Notificaciones eliminadas para la sala: $room');
    } catch (e) {
      debugPrint('Error al eliminar notificaciones: $e');
    }
  }

  @pragma("vm:entry-point")
  static Future<void> notificationTapBackground(NotificationResponse notificationResponse) async {
    if(notificationResponse.input != null) {
      try {
        await initializeTranslations();
        final message = chatMessageFromJson(notificationResponse.payload!);
        final service = FlutterBackgroundService();
        final isRunning = await service.isRunning();

        // Preparar el mensaje a enviar
        final messageData = CreateMessage(
          conversation: message.conversation,
          text: notificationResponse.input.toString(),
          type: message.type
        ).toJson();

        if (!isRunning) {
          await _startServiceAndSendMessage(service, messageData);
        } else {
          await _sendMessage(service, messageData);
        }

        // deleteRoomMessages(message.conversation);
      } catch (e) {
        debugPrint("Error in notificationTapBackground: $e");
      }
    }
  }

  static Future<void> _startServiceAndSendMessage(
    FlutterBackgroundService service, 
    Map<String, dynamic> messageData,
  ) async {
    await initializeService();
    startBackgroundService();
    
    // Esperar por conexión con timeout
    final completer = Completer<void>();
    final subscription = service.on('connected_socket').listen((_) {
      if (!completer.isCompleted) {
        service.invoke('new_message', messageData);
        completer.complete();
      }
    });
    
    // Timeout después de 10 segundos
    Timer(const Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        subscription.cancel();
        completer.completeError(TimeoutException("Socket connection timeout"));
      }
    });
    
    await completer.future;
  }

  static Future<void> _sendMessage(
    FlutterBackgroundService backgroundService, 
    Map<String, dynamic> messageData,
  ) async {
    backgroundService.invoke('new_message', messageData);
  }
  @pragma("vm:entry-point")
  static Future<void> deleteAllNotifications() async {
    try {
    // 1. Limpiar listas en memoria
    _roomMessages.clear();
    // _userMessages.clear();
    
    // 2. Cancelar todas las notificaciones activas
    final activeNotifications = await _notificationsPlugin.getActiveNotifications();
    
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