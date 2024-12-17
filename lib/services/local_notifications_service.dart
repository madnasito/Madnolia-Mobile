
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/routes/routes.dart';
import '../models/chat/message_model.dart' as chat;

class LocalNotificationsService {
   // Instance of Flutternotification plugin
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  

  static void initialize() {
      // Initialization  setting for android
      const InitializationSettings initializationSettingsAndroid =
          InitializationSettings(
              android: AndroidInitializationSettings("@mipmap/ic_launcher"));
      _notificationsPlugin.initialize(
        initializationSettingsAndroid,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        // to handle event when we receive notification 
        onDidReceiveNotificationResponse: (details) {
          print(details);
          if (details.payload != null) {
            final context = navigatorKey.currentContext;
            GoRouter.of(context!).pushNamed("match", extra: details.payload);
          }
        },
      );
  }

  static final List<List<chat.Message>> _messages = []; // Lista para almacenar mensajes  
  
  static Future<void> displayMessage(chat.Message message) async {
    try {
      const String groupChannelId = 'messages';
      const String groupChannelName = 'Messages';
      const String groupChannelDescription = 'Canal de mensajes';
      const String groupKey = 'com.example.yourapp.GROUP_KEY';
      // Agregar el nuevo mensaje a la lista

      if(_messages.isEmpty){
        
        _messages.add([message]);
      }else{

        bool existsGroup = false;

        for (var group in _messages) {
          if(group[0].to == message.to){
            existsGroup = true;
            group.add(message);
            break;
          }
        }

        if(!existsGroup) _messages.add([message]);

        print(existsGroup);
      }
     
      for (var i = 0; i < _messages.length; i++) {
        
        List<Message> notiMessages = _messages[i].map((message) => Message(message.text, message.date, Person(name: message.user.name))).toList();
        // Configurar la notificación
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
                "Respond",
                allowGeneratedReplies: true,
                inputs: [
                   AndroidNotificationActionInput(
                    label: "Message",
                    allowFreeFormInput: true
                  ),
                  
                ],
              )
            ],
            styleInformation: MessagingStyleInformation(
              Person(name: message.user.name, bot: false),
              groupConversation: true,
              conversationTitle: _messages[i][0].to,
              messages: notiMessages,
            ),
          ),
        );

        // Mostrar o actualizar la notificación
        await _notificationsPlugin.show(
          i,
          null,
          null, notificationDetails,
          payload: message.to,);
      }

      
       final inboxStyleInformation = InboxStyleInformation(
          [],
          contentTitle: '${_messages.length} messages',
          summaryText: '${_messages.length} messages',);
        

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            groupChannelId, groupChannelName,
            channelDescription: groupChannelDescription,
            styleInformation: inboxStyleInformation,
            
            groupKey: groupKey,
            setAsGroupSummary: true
          );
      NotificationDetails notificationSummaryDetails =
          NotificationDetails(android: androidNotificationDetails);
      
      await _notificationsPlugin.show(
          -1, '${_messages.length} messages',null , notificationSummaryDetails);

    } catch (e) {
      print("Error al mostrar la notificación: $e");
    }
  }

  static Future<void> displayInvitation(chat.Message message) async {
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

  static Future<void> matchReady(MatchReady payload) async {
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
    print(notificationResponse);
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
}

  static Future<void> deleteRoomMessages(String room) async {
    if (_messages.isEmpty) return;

    for (int i = 0; i <= _messages.length; i++) {
      if(_messages[i][0].to == room){
        // _notificationsPlugin.cancel(id)
        _messages.removeAt(i);
        
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
      print(notificationResponse);
      
  }
  static Future<List<ActiveNotification>> getActiveNotifications(String channelId) async {
    final List<ActiveNotification> activeNotifications =
        await _notificationsPlugin.getActiveNotifications();

    if (activeNotifications.isNotEmpty) {
      for (var notification in activeNotifications) {
        print('ID: ${notification.id}, Title: ${notification.title}, Payload: ${notification.payload}, channel: ${notification.channelId}');
      }

      
      return activeNotifications.where((notification) => notification.channelId == channelId).toList();
    } else {
      print('No hay notificaciones activas.');
      return [];
    }
  }

}