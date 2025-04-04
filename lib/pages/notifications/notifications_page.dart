import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/notification/notification_model.dart' show NotificationModel;
import 'package:madnolia/services/notifications_service.dart';
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
            SizedBox(height: 10),
            CenterTitleAtom(text: translate("CHAT.MESSAGES")),
            FutureBuilder(
              future: NotificationsService().getUserNotifications(),
              builder: (BuildContext context, AsyncSnapshot<List<NotificationModel>> snapshot) {
                if(snapshot.hasData){
                  return Center(child: Text("Loaded"));
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
              
            )
          ],
        ),
      )
    );
  }
}

class AtomRequestNotificationTile extends StatelessWidget {

  final NotificationModel notification;
  const AtomRequestNotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.insert_invitation_rounded),
      title: Text("You have a new invitation to ${notification.title}"),
      subtitle: Text(notification.subtitle),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () => context.pushNamed('match', extra: notification.path),
    );
  }
}

class AtomInvitationNotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const AtomInvitationNotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.insert_invitation_rounded),
      title: Text("${notification.title} wants connect with you"),
      subtitle: Text(notification.subtitle),
      trailing: Icon(Icons.person_add_alt_outlined),
      onTap: () => context.pushNamed('match', extra: notification.path),
    );
  }
}