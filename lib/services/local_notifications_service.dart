import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:madnolia/models/match/match_ready_model.dart';
import '../models/chat/message_model.dart' as ChatMessage;

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
        // to handle event when we receive notification 
        onDidReceiveNotificationResponse: (details) {
          print(details);
          if (details.input != null) {}
        },
      );
  }

  

  static Future<void> displayMessage(ChatMessage.Message message) async {
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
            priority: Priority.high,
            actions: [

            ]
            ),
      );
      await _notificationsPlugin.show(id, message.user.name,message.text, notificationDetails);
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  static Future<void> displayInvitation(ChatMessage.Message message) async {
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
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, "Match ready","${payload.title} has started", notificationDetails);
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

  static void notificationTapBackground(NotificationResponse notificationResponse) {
  
  }
}
