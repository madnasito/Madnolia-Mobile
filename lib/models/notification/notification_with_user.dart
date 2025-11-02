import 'package:madnolia/database/database.dart';

class NotificationWithUser {
  final NotificationData notification;
  final NotificationData user;

  NotificationWithUser({
    required this.notification,
    required this.user,
  });
}