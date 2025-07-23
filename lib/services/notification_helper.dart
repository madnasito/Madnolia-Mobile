import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationHelper {
  static const String channelId = 'silent_service_channel';
  static const String channelName = 'Background Service';
  static const String channelDescription = 'Keeps your gaming connections active';
  
  static Future<void> createNotificationChannel() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.none, // Low importance to minimize user distraction
      playSound: false,
      enableVibration: false,
      showBadge: false,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
        
    debugPrint('Notification channel created: $channelId');
  }
  
  static Future<void> initializeNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await createNotificationChannel();
  }
}
