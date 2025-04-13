
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/models/match/minimal_match_model.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/services/database/match_db.dart';
import 'package:madnolia/services/match_service.dart';
import '../models/chat/message_model.dart' as chat;

class LocalNotificationsService {
   // Instance of Flutternotification plugin
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  

  static Future<void> initialize() async {
      const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher")
        );

        
      _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
        
      _notificationsPlugin.initialize(
        initializationSettingsAndroid,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        // to handle event when we receive notification 
        onDidReceiveNotificationResponse: (details) {
          if (details.payload != null) {
            final context = navigatorKey.currentContext;
            GoRouter.of(context!).pushNamed("match", extra: details.payload);
          }
        },
      );
  }

  static final List<List<chat.GroupMessage>> _roomMessages = []; // Lista para almacenar mensajes  
  

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

  static Future<void> displayMessage(chat.GroupMessage message) async {
    try {
      await initializeTranslations();
      const String groupChannelId = 'messages';
      const String groupChannelName = 'Messages';
      const String groupChannelDescription = 'Canal de mensajes';
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

      // Obtener información del match UNA SOLA VEZ
      final matchProvider = MatchProvider();
      await matchProvider.open();
      
      MinimalMatchDb? matchDb;
      if(await matchProvider.getMatch(message.to) == null) {
        final Map<String, dynamic> matchInfo = await MatchService().getMatch(message.to);
        final MinimalMatch minimalMatch = MinimalMatch.fromJson(matchInfo);
        matchDb = MinimalMatchDb(
          date: minimalMatch.date, 
          platform: minimalMatch.platform, 
          title: minimalMatch.title, 
          id: minimalMatch.id
        );
        await matchProvider.insert(matchDb);
      } else {
        matchDb = await matchProvider.getMatch(message.to);
      }

      // Procesar cada grupo de mensajes
      for (var i = 0; i < _roomMessages.length; i++) {
        final currentGroup = _roomMessages[i];
        
        // Obtener el título específico para ESTE grupo
        MinimalMatchDb? groupMatchDb;
        if(await matchProvider.getMatch(currentGroup[0].to) != null) {
          groupMatchDb = await matchProvider.getMatch(currentGroup[0].to);
        }

        List<Message> notiMessages = currentGroup.map((msg) => 
          Message(msg.text, msg.date, Person(name: msg.user.name))
        ).toList();

        NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            groupKey: groupKey,
            groupChannelId,
            groupChannelName,
            channelDescription: groupChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            actions: [
              AndroidNotificationAction(
                message.id,
                translate("FORM.INPUT.RESPOND"),
                allowGeneratedReplies: true,
                inputs: [
                  AndroidNotificationActionInput(
                    label: translate("CHAT.MESSAGE"),
                    allowFreeFormInput: true,
                  ),
                ],
              )
            ],
            styleInformation: MessagingStyleInformation(
              Person(name: message.user.name, bot: false),
              groupConversation: true,
              // Usar el título específico de este grupo
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
          payload: currentGroup[0].to,
        );
      }

      // Notificación resumen
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
          setAsGroupSummary: true
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
    } finally {
      // Cerrar la conexión a la base de datos
      // (Considera mantenerla abierta si haces muchas operaciones seguidas)
    }
  }

  static Future<void> displayInvitation(chat.GroupMessage message) async {
    // To display the notification in device
    try {
      

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "Channel Id",
            "Main Channel",
            groupKey: "gfg",
            color: Colors.green,             
            playSound: true, 
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, message.user.name,message.text, notificationDetails);
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  static Future<void> matchReady(dynamic data) async {
    // To display the notification in device
    try {
      final MatchReady payload = MatchReady.fromJson(data);
      debugPrint(payload.title);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "Channel Id",
            "Main Channel",
            groupKey: "gfg",
            color: Colors.green,             
            playSound: true,
            timeoutAfter: 1000 * 60 * 5,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(
        id, "Match ready",
        "${payload.title} has started",
        notificationDetails,
        payload: payload.match);
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
        GoRouter.of(context!).pushNamed("match", extra: notificationResponse.payload);
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