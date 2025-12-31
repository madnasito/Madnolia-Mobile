
import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
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
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:uuid/uuid.dart';
import '../models/chat/chat_message_model.dart';


@pragma("vm:entry-point")
class LocalNotificationsService {

  static final _userRepository = RepositoryManager().user;
  static final _matchRepository = RepositoryManager().match;
   // Instance of Flutternotification plugin
   @pragma("vm:entry-point")
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @pragma("vm:entry-point")
  static Future<void> initialize() async {
      const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/launcher_icon")
        );

     {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final version = androidInfo.version.sdkInt;
      debugPrint(version.toString());
      if(version > 32){
        final androidPlugin = _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        
        // Verificar si ya tenemos los permisos
        final bool granted = await androidPlugin?.areNotificationsEnabled() ?? false;
        
        if (!granted) {
          await androidPlugin?.requestNotificationsPermission();
        }
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
    // Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio > 1.0 
    //     ? const Locale('en') // Fallback if needed
    //     : const Locale('en'); // Replace with actual logic to get locale

    // String langCode = deviceLocale.languageCode;

    // List<String> supportedLangs = ['en', 'es'];

    // await LocalizationDelegate.create(
    //   fallbackLocale: supportedLangs.contains(langCode) ? langCode : 'en',
    //   supportedLocales: supportedLangs,
    // );
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
      if (message.type == ChatMessageType.match) {
        title = (await _matchRepository.getMatchById(message.conversation)).title;
        debugPrint("Message type is Match. Title: $title");
      } else {
        debugPrint("Message type is User. Calculating other user's name...");
        final otherUser = await _userRepository.getUserByFriendship(message.conversation);
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
      final currentUserImage = await getRoundedImageBytes(CachedNetworkImageProvider(currentUserDb.thumb));

      final Person me = Person(
        key: currentUserDb.id,
        name: t.UTILS.YOU,
        icon: ByteArrayAndroidIcon(currentUserImage),
      );

      List<Message> notiMessages = await Future.wait(targetGroup.map((msg) async {
        final user = userData[msg.creator]!;
        final image = await getRoundedImageBytes(CachedNetworkImageProvider(user.thumb));
        return Message(
          msg.content,
          msg.date,
          Person(
            name: user.name,
            bot: false,
            icon: ByteArrayAndroidIcon(image),
            key: user.id
          )
        );
      }).toList());

      final lastSender = await _userRepository.getUserById(message.creator);
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
              t.FORM.INPUT.REPLY,
              inputs: [AndroidNotificationActionInput(label: t.CHAT.MESSAGE, allowFreeFormInput: true)],
            ),
            AndroidNotificationAction(
              message.id,
              t.FORM.INPUT.MARK_AS_READ,
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
            if (group.first.type == ChatMessageType.match) {
              chatTitle = (await _matchRepository.getMatchById(group.first.conversation)).title;
            } else {
              final otherUserId = await _userRepository.getUserByFriendship(group.first.conversation);
              chatTitle = otherUserId?.name;
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
      final matchDb = await _matchRepository.getMatchById(invitation.match);
      final userDb = await _userRepository.getUserById(invitation.user);
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
            subText: t.NOTIFICATIONS.MATCH_INVITATION,
            styleInformation: BigPictureStyleInformation(
              icon,
              contentTitle: "${t.NOTIFICATIONS.INVITED_TO} ${invitation.name}",
              summaryText: "@${userDb.username}",
            ),
            // styleInformation: BigPictureStyleInformation(bigPicture),
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, null, null, notificationDetails, payload: json.encode(matchDb.toJson()));
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @pragma("vm:entry-point")
  static Future<void> displayMatchReady(MatchReady payload) async {
    // To display the notification in device
    await initializeTranslations();
    try {
      final matchDb = await _matchRepository.getMatchById(payload.match);
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
        id, t.NOTIFICATIONS.MATCH_READY,
        t.NOTIFICATIONS.MATCH_STARTED(name: payload.title),
        notificationDetails,
        payload: json.encode(matchDb.toJson()));
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @pragma("vm:entry-point")
  static void onDidReceiveNotificationResponse(NotificationResponse details) async {

      if (details.payload == null || details.payload!.isEmpty) {
        debugPrint("Notification payload is empty.");
        return;
      }

      // _roomMessages.clear();
      // _userMessages.clear();

      
      try {
        MatchData matchDb = MatchData.fromJson(json.decode(details.payload!));
        final context = navigatorKey.currentContext;
        GoRouter.of(context!).push("/match/${matchDb.id}");
        return;
      } catch (e) {
        debugPrint(e.toString());
      }

      try {
        final ChatMessage message = chatMessageFromJson(details.payload!);
        final context = navigatorKey.currentContext;
        switch (message.type) {
          case ChatMessageType.user:
            UserData userDb = await _userRepository.getUserById(message.creator);
            const storage = FlutterSecureStorage();

            if(userDb.id == await storage.read(key: "userId")) {
              userDb = await _userRepository.getUserByFriendship(message.conversation) ?? userDb;
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
        _roomMessages.removeWhere((group) => 
            group.isNotEmpty && group.first.conversation == room);
        
        // 2. Obtener ID específico para esta sala
        int roomNotificationId = room.hashCode;
        
        // 3. Cancelar solo la notificación específica de esta sala
        await _notificationsPlugin.cancel(roomNotificationId);
        
        // 4. Si hay más grupos activos, actualizar el resumen
        if (_roomMessages.isNotEmpty) {
            await _updateSummaryNotification();
        } else {
            // 5. Si no hay más grupos, cancelar el resumen también
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
                    chatTitle = (await _matchRepository.getMatchById(group.first.conversation)).title;
                } else {
                    final otherUserId = await _userRepository.getUserByFriendship(group.first.conversation);
                    chatTitle = otherUserId?.name;
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
            -1, // ID fijo para el resumen
            '${_roomMessages.length} chats',
            '${_roomMessages.fold(0, (sum, group) => sum + group.length)} new messages',
            notificationSummaryDetails
        );
    } catch (e) {
        debugPrint('Error updating summary: $e');
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

        final uuid = Uuid();
        final messageData = CreateMessage(
          id: uuid.v4(),
          conversation: message.conversation,
          content: notificationResponse.input.toString(),
          type: message.type,
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
    
    service.on('service_started').listen((_) {
      debugPrint('Service started, sending message...');
      service.invoke('new_message', messageData);
    });
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