
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/invitation_model.dart';

import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/services/database/friendship_db.dart';
import 'package:madnolia/services/database/match_db.dart';
import 'package:madnolia/services/database/user_db.dart' show UserDb;
import 'package:madnolia/services/friendship_service.dart';
import 'package:madnolia/utils/match_db_util.dart' show getMatchDb;
import 'package:madnolia/utils/user_db_util.dart' show getUserDb;
import '../models/chat/message_model.dart';

class LocalNotificationsService {
   // Instance of Flutternotification plugin
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
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
        onDidReceiveNotificationResponse: (details) async {
          _roomMessages.clear();
          _userMessages.clear();
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
                final UserDb userDb = await getUserDb(message.user);
                final ChatUser chatUser = ChatUser(id: userDb.id, name: userDb.name, thumb: userDb.thumb, username: userDb.username);
                if(context!.mounted) GoRouter.of(context).pushNamed("user_chat", extra: chatUser);
                break;
              default:
                 GoRouter.of(context!).push("/match/${message.to}");

            }
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      );
  }

  static final List<List<ChatMessage>> _roomMessages = []; // Lista para almacenar mensajes  
  static final List<List<ChatMessage>> _userMessages = [];

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

  static Future<String> imageProviderToBase64(ImageProvider imageProvider) async {
    // Create a completer to handle the asynchronous image loading
    final completer = Completer<Uint8List>();
    
    // Convert ImageProvider to ImageStream and listen for the image data
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      if (!completer.isCompleted) {
        completer.complete(bytes);
      }
    });
    
    imageStream.addListener(listener);
    
    // Wait for the image bytes
    final bytes = await completer.future;
    
    // Remove the listener when done
    imageStream.removeListener(listener);
    
    // Convert to base64
    return base64Encode(bytes);
  }

  static Future<Uint8List> imageProviderToUint8List(ImageProvider imageProvider) async {
    // Create a completer to handle the asynchronous image loading
    final completer = Completer<Uint8List>();
    
    // Convert ImageProvider to ImageStream and listen for the image data
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      if (!completer.isCompleted) {
        completer.complete(bytes);
      }
    });
    
    imageStream.addListener(listener);
    
    // Wait for the image bytes
    final bytes = await completer.future;
    
    // Remove the listener when done
    imageStream.removeListener(listener);
    
    // Convert to base64
    return bytes;
  }

  static Future<FriendshipDb> getFriendshipDb(String id) async {
    try {
      final friendshipProvider = FriendshipProvider();
      await friendshipProvider.open();
      
      // First try to get from local DB
      FriendshipDb? friendshipDb = await friendshipProvider.getFriendship(id);
      
      if (friendshipDb == null) {
        // Create storage
        final storage = FlutterSecureStorage();
        final String? userId = await storage.read(key: "userId");

        if (userId == null) {
          throw Exception("User ID not found in secure storage");
        }

        // Fetch from API if not found locally
        final friendshipInfo = await FriendshipService().getFriendwhipWithUser(userId);
        friendshipDb = FriendshipDb.fromMap(friendshipInfo.toJson());
        
        // Store in local DB
        await friendshipProvider.insert(friendshipDb);
      }

      return friendshipDb;
    } catch (e) {
      debugPrint('Error in getFriendshipDb: $e');
      rethrow;
    } finally {
      // Consider whether to close here or manage connection lifecycle differently
    }
  }

  static Future<void> displayRoomMessage(ChatMessage message) async {
  try {
    await initializeTranslations();
    const String groupChannelId = 'messages';
    const String groupChannelName = 'Messages';
    const String groupChannelDescription = 'Messages channel';
    const String groupKey = 'com.madnolia.app.GROUP_KEY';

    // Agregar el nuevo mensaje a la lista
    bool messageAdded = false;
    
    for (var group in _roomMessages) {
      if(group[0].to == message.to) {
        group.add(message);
        messageAdded = true;
        break;
      }
    }
    
    if(!messageAdded) {
      _roomMessages.add([message]);
    }

    // Procesar cada grupo de mensajes
    for (var i = 0; i < _roomMessages.length; i++) {
      final currentGroup = _roomMessages[i];
      final roomId = currentGroup[0].to;

      // Obtener información del match
      MinimalMatchDb? groupMatchDb = await getMatchDb(roomId);

      // Pre-cargar datos de todos los usuarios en este grupo
      final userIds = currentGroup.map((msg) => msg.user).toSet();
      final userData = <String, UserDb>{};
      
      for (final userId in userIds) {
        userData[userId] = await getUserDb(userId);
      }

      // Crear mensajes de notificación con los remitentes correctos
      List<Message> notiMessages = await Future.wait(currentGroup.map((msg) async{
        final user = userData[msg.user]!;
        final image = await imageProviderToUint8List(CachedNetworkImageProvider(user.thumb));
        return Message(
          msg.text,
          msg.date,
          Person(
            name: user.name,
            bot: false,
            icon: ByteArrayAndroidIcon(image) // Opcional: mostrar avatar
          )
        );
      }).toList()) ;

      // Persona principal de la notificación (el último remitente)
      final lastSender = userData[currentGroup.last.user]!;
      final image = await imageProviderToUint8List(CachedNetworkImageProvider(lastSender.thumb));
      
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          groupKey: groupKey,
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          importance: Importance.high,
          icon: 'ic_notifications',
          priority: Priority.high,
          largeIcon: ByteArrayAndroidBitmap(image),
          actions: [
            AndroidNotificationAction(
              message.id,
              translate("FORM.INPUT.RESPOND"),
              inputs: [
                AndroidNotificationActionInput(
                  label: translate("MESSAGE"),
                  allowFreeFormInput: false,
                ),
              ],
            )
          ],
          styleInformation: MessagingStyleInformation(
            Person(
              name: lastSender.name,
              bot: false,
              icon: ByteArrayAndroidIcon(image),
              key: lastSender.id // Identificador único
            ),
            groupConversation: true,
            conversationTitle: groupMatchDb?.title ?? 'Match messages',
            messages: notiMessages,
          ),
        ),
      );

      await _notificationsPlugin.show(
        i,
        null,
        null, 
        notificationDetails,
        payload: chatMessageToJson(message),
      );
    }

    // Notificación resumen (sin cambios)
    final inboxStyleInformation = InboxStyleInformation(
      [],
      contentTitle: '${_roomMessages.length} ${translate("CHAT.MESSAGES")}',
      summaryText: '${_roomMessages.length} ${translate("CHAT.MESSAGES")}',
    );

    final notificationSummaryDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        groupChannelId, 
        groupChannelName,
        channelDescription: groupChannelDescription,
        styleInformation: inboxStyleInformation,
        groupKey: groupKey,
        setAsGroupSummary: true,
        icon: 'ic_notifications'
      ),
    );
    
    await _notificationsPlugin.show(
      -1, 
      '${_roomMessages.length} ${translate("CHAT.MESSAGES")}',
      null,
      notificationSummaryDetails
    );

  } catch (e) {
    debugPrint('Error en displayMessage: $e');
  }
}
  
  
  static Future<void> displayUserMessage(ChatMessage message) async {
    try {
      await initializeTranslations();
      const String individualChannelId = 'individual_messages';
      const String individualChannelName = 'Individual Messages';
      const String individualChannelDescription = 'Individual messages channel';
      const String individualKey = 'com.madnolia.app.INDIVIDUAL_KEY';


      // 1. Actualizar lista de mensajes agrupados por sala/chat
      bool groupExists = false;
      for (var group in _userMessages) {
        if (group[0].to == message.to) {
          group.add(message);
          groupExists = true;
          break;
        }
      }
      
      if (!groupExists) {
        _userMessages.add([message]);
      }


      for (var i = 0; i < _userMessages.length; i++) {
        final currentGroup = _userMessages[i];
        // final friendshipId = currentGroup[0].to;

        final UserDb user = await getUserDb(currentGroup[0].user);

        // Crear mensajes de notificación con los remitentes correctos
        List<Message> notiMessages = await Future.wait(currentGroup.map((msg) async{
          final image = await imageProviderToUint8List(CachedNetworkImageProvider(user.thumb));
          return Message(
            msg.text,
            msg.date,
            Person(
              name: user.name,
              bot: false,
              icon: ByteArrayAndroidIcon(image) // Opcional: mostrar avatar
            )
          );
        }).toList()) ;

        final image = await imageProviderToUint8List(CachedNetworkImageProvider(user.thumb));

        NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            groupKey: individualKey,
            individualChannelId,
            individualChannelName,
            channelDescription: individualChannelDescription,
            importance: Importance.high,
            icon: 'ic_notifications',
            largeIcon: _userMessages.length > 1 ? ByteArrayAndroidBitmap(image) : null,
            priority: Priority.high,
            actions: [
              AndroidNotificationAction(
                message.id,
                translate("FORM.INPUT.RESPOND"),
              cancelNotification: true,
                inputs: [
                  AndroidNotificationActionInput(
                    label: translate("CHAT.MESSAGE"),
                    allowFreeFormInput: true,
                  ),
                ],
              )
            ],
            styleInformation: MessagingStyleInformation(
              Person(
                name: user.name,
                bot: false,
                icon: ByteArrayAndroidIcon(image),
                key: user.id // Identificador único
              ),
              groupConversation: true,
              conversationTitle: user.name ,
              messages: notiMessages,
            ),
          ),
        );

        await _notificationsPlugin.show(
          i,
          null,
          null, 
          notificationDetails,
          payload: chatMessageToJson(message)
        );
      }

      // Notificación resumen (sin cambios)
        final inboxStyle = InboxStyleInformation(
          [],
          contentTitle: '${_userMessages.length} ${translate("CHAT.MESSAGES")}',
          summaryText: '${_userMessages.length} ${translate("CHAT.MESSAGES")}',
        );

      
      final notificationSummaryDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          individualChannelId, 
          individualChannelName,
          channelDescription: individualChannelDescription,
          styleInformation: inboxStyle,
          groupKey: individualKey,
          setAsGroupSummary: true,
          icon: 'ic_notifications'
        ),
      );

      await _notificationsPlugin.show(
        -1, 
        '${_userMessages.length} ${translate("CHAT.MESSAGES")}',
        null,
        notificationSummaryDetails
      );


    } catch (e) {
      debugPrint("Error en notificaciones de chat: $e");
    }
  }

  // Función de ejemplo para obtener información de la sala
  static Future<Map<String, dynamic>> getChatRoomInfo(String roomId) async {
    // Implementa esta función según tu estructura de datos
    return {
      'name': 'Nombre de la Sala',
      'participants': ['user1', 'user2'],
      'image': 'url_de_imagen'
    };
  }

  static Future<void> displayInvitation(Invitation invitation) async {
    // To display the notification in device
    
    try {

      await initializeTranslations();
      final matchDb = await getMatchDb(invitation.match);
      final image = await imageProviderToBase64(CachedNetworkImageProvider(invitation.img));
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
              summaryText: "@${invitation.user}"
            ),
            // styleInformation: BigPictureStyleInformation(bigPicture),
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, null, null, notificationDetails, payload: matchDb?.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  static Future<void> matchReady(dynamic data) async {
    // To display the notification in device
    try {
      final MatchReady payload = MatchReady.fromJson(data);
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
        id, "Match ready",
        "${payload.title} has started",
        notificationDetails,
        payload: matchDb?.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }

  }
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
}

  static Future<void> deleteRoomMessages(String room) async {
    if (_roomMessages.isEmpty) return;

    for (int i = 0; i <= _roomMessages.length; i++) {
      if(_roomMessages[i][0].to == room){
        // _notificationsPlugin.cancel(id)
        _roomMessages.removeAt(i);
        
        final activeMessages = await getActiveNotifications("messages");

        for (var message in activeMessages) {
          _notificationsPlugin.cancel(message.id!);
        }
        break;
      }
      i++;
    }
  }

  static void notificationTapBackground(NotificationResponse notificationResponse) {      
      if (notificationResponse.payload != null) {
        final context = navigatorKey.currentContext;
        GoRouter.of(context!).push("/match/${notificationResponse.payload}");
      }
      
  }
  static Future<List<ActiveNotification>> getActiveNotifications(String channelId) async {
    final List<ActiveNotification> activeNotifications =
        await _notificationsPlugin.getActiveNotifications();

    if (activeNotifications.isNotEmpty) {
      
      return activeNotifications.where((notification) => notification.channelId == channelId).toList();
    } else {
      debugPrint('There are not active notifications');
      return [];
    }
  }

  static Future<void> deleteAllNotifications() async {
    final List<ActiveNotification> activeNotifications =
        await _notificationsPlugin.getActiveNotifications();
    
    for (var notification in activeNotifications) {
      await _notificationsPlugin.cancel(notification.id!);
    }
  }
}