

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
          if (details.input != null) {}
        },
      );
  }

  

  static Future<void> display(String message) async {
    // To display the notification in device
    try {
      
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "Channel Id",
            "Main Channel",
            groupKey: "gfg",
            color: Colors.green, 
            importance: Importance.max,
            
           
            // different sound for 
            // different notification
            playSound: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, "Test noti",message, notificationDetails);
    } catch (e) {
      debugPrint(e.toString());
    }

  }
}
