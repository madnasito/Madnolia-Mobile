import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/enums/bloc_status.enum.dart';

import '../../blocs/user/user_bloc.dart';
import '../../enums/notification_type.enum.dart';
import '../atoms/notifications/atom_invitation_notification.dart';
import '../atoms/notifications/atom_request_notification.dart';

class OrganismNotifications extends StatelessWidget {
  const OrganismNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.initial:
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

          case BlocStatus.success:
            // Message when there is no notification
            if (state.data.isEmpty) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(t.NOTIFICATIONS.EMPTY)),
              );
            }
            return NotificationsLoader();

          case BlocStatus.failure:
            if (state.data.isEmpty) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(t.NOTIFICATIONS.ERROR_LOADING)),
              );
            }
            return const NotificationsLoader();
        }
      },
    );
  }
}

class NotificationsLoader extends StatefulWidget {
  const NotificationsLoader({super.key});

  @override
  State<NotificationsLoader> createState() => _NotificationsLoaderState();
}

class _NotificationsLoaderState extends State<NotificationsLoader> {
  late final NotificationsBloc notificationsBloc;

  @override
  void initState() {
    super.initState();

    notificationsBloc = context.read<NotificationsBloc>();
    // notificationsBloc.add(LoadNotifications());
    // notificationsBloc.add(WatchNotifications());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundService = FlutterBackgroundService();

    final userBloc = context.watch<UserBloc>();
    userBloc.add(RestoreNotifications());

    return ListView.builder(
      shrinkWrap: true,
      itemCount: notificationsBloc.state.data.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final data = notificationsBloc.state.data[index];
        return data.notification.type == NotificationType.request
            ? AtomRequestNotification(data: data)
            : AtomInvitationNotification(
                data: data,
                backgroundService: backgroundService,
              );
      },
    );
  }
}
