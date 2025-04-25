import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:madnolia/widgets/atoms/notifications/atom_invitation_notification.dart';
import 'package:madnolia/widgets/atoms/notifications/atom_request_notification.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CenterTitleAtom(text: translate("NOTIFICATIONS.TITLE")),
            const SizedBox(height: 10),
            FutureBuilder(
              future: NotificationsService().getUserNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.ERROR_LOADING"))));
                }
                if (snapshot.data!.isEmpty) {
                  return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.EMPTY"))));
                }
                final userBloc = context.watch<UserBloc>();
                userBloc.restoreNotifications();
                return Column(
                  children: snapshot.data!.map((notification) =>
                    notification.type == 0
                      ? AtomInvitationNotification(notification: notification)
                      : AtomRequestNotification(notification: notification)
                  ).toList(),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}