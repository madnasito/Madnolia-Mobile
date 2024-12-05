// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
// import 'package:madnolia/main.dart';
// import 'package:madnolia/routes/routes.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NotificationService {
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelGroupKey: 'high_importance_channel',
//           channelKey: 'high_importance_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: const Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           importance: NotificationImportance.Max,
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           playSound: true,
//           criticalAlerts: true,
          
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'high_importance_channel_group',
//           channelGroupName: 'Group 1',
//         )
//       ]
//     );

//     await AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       },
//     );

  
//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );

//     // AndroidForegroundService.startAndroidForegroundService(
//     //   foregroundStartMode: ForegroundStartMode.stick,
//     //   foregroundServiceType: ForegroundServiceType.phoneCall,
      
//     // );

//   }

//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     BuildContext context = MyApp.navigatorKey.currentContext!;
//     await showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text('Get Notified!',
//                 style: Theme.of(context).textTheme.titleLarge),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         'assets/animated-bell.gif',
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                     'Allow Awesome Notifications to send you beautiful notifications!'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Deny',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     userAuthorized = true;
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Allow',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.deepPurple),
//                   )),
//             ],
//           );
//         });
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

//   /// Use this method to detect when a new notification or a schedule is created
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreatedMethod');
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayedMethod');
//   }

//   /// Use this method to detect if the user dismissed a notification
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint('onDismissActionReceivedMethod');
//   }
//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint('onActionReceivedMethod');
//     final payload = receivedAction.payload ?? {};
//     final action = receivedAction.buttonKeyPressed;
//     final notificationId = receivedAction.id;

//      if (action == "") {
//       if (payload.containsKey("match")) {
//         router.go("/match", extra: payload["match"]!);
//       }
//     }

//     if (action == "accept") {

//       final BuildContext? context = MyApp.navigatorKey.currentContext;

//       final socketsBloc = context?.read<SocketsBloc>();
//       socketsBloc?.state.socketHandler.socket.emit("join_to_match", payload["match"]);
//     }
//     if (action == "reply") {
//       final BuildContext? context = MyApp.navigatorKey.currentContext;

//       final socketsBloc = context?.read<SocketsBloc>();
//       socketsBloc?.state.socketHandler.socket.emit("message",
//           {"text": receivedAction.buttonKeyInput, "room": payload["match"]});
//       AwesomeNotifications().dismiss(notificationId!);
//     }

//   }

//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//      AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecond,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         summary: summary,
//         category: category,
//         payload: payload,
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval,
//               timeZone:
//                   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true,
//             )
//           : null,
//     );
//   }

  
// }