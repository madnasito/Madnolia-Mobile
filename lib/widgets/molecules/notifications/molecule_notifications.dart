import 'package:flutter/material.dart';
import 'package:madnolia/enums/notification_type.enum.dart';
import 'package:madnolia/models/notification/notification_model.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:madnolia/widgets/atoms/notifications/atom_invitation_notification.dart';
import 'package:madnolia/widgets/atoms/notifications/atom_request_notification.dart';

class MoleculeNotifications extends StatelessWidget {

  final List<NotificationModel> notifications;
  const MoleculeNotifications({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {

  // avoid multiple notifications services instances
  final notificationsService = NotificationsService();

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        if(notifications[index].type == NotificationType.invitation) {
          return AtomInvitationNotification(notification: notifications[index], notificationsService: notificationsService, );
        } else {
          return AtomRequestNotification(notification: notifications[index]);
        }

     },);
  }
}