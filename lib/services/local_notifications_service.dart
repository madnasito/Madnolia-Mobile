import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:madnolia/models/match/match_ready_model.dart';
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
        // to handle event when we receive notification 
        onDidReceiveNotificationResponse: (details) {
          print(details);
          if (details.input != null) {}
        },
      );
  }

  

  static Future<void> displayMessage(chat.Message message) async {
    // To display the notification in device
    try {

      const String groupKey = 'com.android.example.MATCH_MESSAGES';
      const String groupChannelId = 'messages';
      const String groupChannelName = 'grouped channel name';
      const String groupChannelDescription = 'grouped channel description';
      
      await LocalNotificationsService.getActiveNotifications(groupChannelId);

      Bitmap bitmapImage = await Bitmap.fromProvider(CachedNetworkImageProvider(message.user.thumb));
      
      final List<ActiveNotification> activeNotifications = await getActiveNotifications(groupChannelId);
      
      final Uint8List imageBytes = bitmapImage.content.buffer.asUint8List();
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails =  NotificationDetails(
        android: AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          groupKey: groupKey,
          setAsGroupSummary: true,
          playSound: true,
          priority: Priority.max,
          showWhen: false,
          importance: Importance.max,
          // styleInformation: MessagingStyleInformation(Person(
          //   bot: false,
          //   name: message.user.name,
          //   important: true,
          //   uri: message.user.username,
          //   icon: ByteArrayAndroidIcon(imageBytes)
          // ), groupConversation: true, conversationTitle: "TEst conversation", messages: [Message(message.text, DateTime.now(), Person(name: message.user.name, bot: false, )), Message(message.text, DateTime.now(), Person(name: message.user.name, bot: false, )), Message(message.text, DateTime.now(), Person(name: message.user.name, bot: false, icon: ByteArrayAndroidIcon(imageBytes)))]),
          //   category: AndroidNotificationCategory.message,
            
            
          // styleInformation: BigPictureStyleInformation(
          //   ByteArrayAndroidBitmap(imageBytes.buffer.asUint8List()),
          //   largeIcon: ByteArrayAndroidBitmap(imageBytes.buffer.asUint8List()),
          //   contentTitle: message.user.name,
          //   summaryText: message.text
          // ),
          actions: [
          ]
        ),
      );

      await _notificationsPlugin.show(id, message.user.name,message.text, notificationDetails);

       // Create a summary notification for the group
      await _notificationsPlugin.show(
        999, // Summary notification ID
        '${message.user.name} sent you a message', // Summary title
        'You have ${activeNotifications.length} new messages', // Summary body
        NotificationDetails(
          android: AndroidNotificationDetails(
            groupChannelId,
            groupChannelName,
            channelDescription: 'Your Channel Description',
            groupKey: groupKey,
            setAsGroupSummary: true, // Important for grouping
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
  );
      
      
      
    } catch (e) {
      debugPrint(e.toString());
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
