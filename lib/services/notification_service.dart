// import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';

class NotificationService {
  static Future initializeNotification() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
        // Channel groups are only visual and are not required
        channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
        debug: true);
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final payload = receivedAction.payload ?? {};
    final action = receivedAction.buttonKeyPressed;
    final notificationId = receivedAction.id;

    if (action == "") {
      if (payload.containsKey("match")) {
        router.go("/match", extra: payload["match"]!);
      }
    }

    if (action == "accept") {
      // SocketService socketService = Provider.of<SocketService>(
      //     MyApp.navigatorKey.currentContext!,
      //     listen: false);
      // socketService.emit("join_to_match", payload["match"]);
    }
    if (action == "reply") {
      // print(MyApp.navigatorKey.currentContext);
      // SocketService socketService = Provider.of<SocketService>(
      //     MyApp.navigatorKey.currentContext!,
      //     listen: false);
      // socketService.emit("message",
      //     {"message": receivedAction.buttonKeyInput, "room": payload["match"]});
      AwesomeNotifications().dismiss(notificationId!);
    }
  }

  static Future<void> showNotification(
      {required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final NotificationCategory? category,
      final String? bigPicture,
      final List<NotificationActionButton>? actionButtons,
      final bool scheduled = false,
      final String? largeIcon,
      
      final int? interval}) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
        backgroundColor: Colors.transparent,
        roundedLargeIcon: true,
        largeIcon: largeIcon,
        id: DateTime.now().millisecond,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }
}
