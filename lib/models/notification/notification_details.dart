import 'package:madnolia/database/database.dart';

class NotificationDetails {
  final NotificationData notification;
  final UserData? user;

  NotificationDetails({
    required this.notification,
    this.user,
  });
}