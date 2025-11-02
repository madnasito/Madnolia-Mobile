import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';

import '../../blocs/user/user_bloc.dart';
import '../../enums/notification_type.enum.dart';
import '../../services/notifications_service.dart';
import '../atoms/notifications/atom_invitation_notification.dart';
import '../atoms/notifications/atom_request_notification.dart';

class OrganismNotifications extends StatelessWidget {
  const OrganismNotifications({super.key});

  @override
  Widget build(BuildContext context) {

    final notificationsBloc = context.watch<NotificationsBloc>();
    notificationsBloc.add(LoadNotifications());

    switch (notificationsBloc.state.status ) {
      case ListStatus.initial:
        return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
      case ListStatus.success:
        // Message when there is no notification
        if(notificationsBloc.state.data.isEmpty) return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.EMPTY"))));
        
        final userBloc = context.watch<UserBloc>();
        // avoid multiple notifications services instances
        final notificationsService = NotificationsService();

        userBloc.restoreNotifications();
        return Column(
          children: notificationsBloc.state.data.map((notification) =>
            notification.type == NotificationType.request
              ? AtomRequestNotification(notification: notification)
              : AtomInvitationNotification(notification: notification, notificationsService: notificationsService,)
          ).toList(),
        );
      case ListStatus.failure:
        return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.ERROR_LOADING"))));
      
    }
  }
}