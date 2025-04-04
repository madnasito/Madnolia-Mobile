import 'package:cached_network_image/cached_network_image.dart';
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
            const SizedBox(height: 10),
            CenterTitleAtom(text: translate("CHAT.MESSAGES")),
            const SizedBox(height: 10),
            FutureBuilder(
              future: NotificationsService().getUserNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return SizedBox(height: 200, child: Center(child: Text('Error loading notifications')));
                }
                if (snapshot.data!.isEmpty) {
                  return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.EMPTY"))));
                }
                return Column(
                  children: snapshot.data!.map((notification) =>
                    notification.type == 0
                      ? AtomInvitationNotificationTile(notification: notification)
                      : AtomRequestNotificationTile(notification: notification)
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

class MoleculeNotificationsList extends StatelessWidget {

  final List<NotificationModel> notifications;
  const MoleculeNotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        if(notifications[index].type == 0) {
          return AtomInvitationNotificationTile(notification: notifications[index]);
        } else {
          return AtomRequestNotificationTile(notification: notifications[index]);
        }

     },);
  }
}

class AtomRequestNotificationTile extends StatelessWidget {

  final NotificationModel notification;
  const AtomRequestNotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45, // Darker background
        borderRadius: BorderRadius.circular(12), // Optional rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), 
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[800],
          backgroundImage: CachedNetworkImageProvider(notification.thumb),),
        title: Text("You have a new invitation to ${notification.title}"),
        subtitle: Text("@${notification.subtitle}", style: TextStyle(
            color: Colors.greenAccent,
            overflow: TextOverflow.ellipsis, // Handle long text
          )),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
        onTap: () => context.pushNamed('match', extra: notification.path),
      ),
    );
  }
}

class AtomInvitationNotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const AtomInvitationNotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45, // Darker background
        borderRadius: BorderRadius.circular(12), // Optional rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), 
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[800],
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(notification.thumb),),
        title: Text("${notification.title} wants connect with you"),
        subtitle: Text("@${notification.subtitle}", style: TextStyle(
            color: Colors.greenAccent, // Lighter grey for subtitle
            overflow: TextOverflow.ellipsis, // Handle long text
          )),
        trailing: Icon(Icons.more_vert_rounded),
        onTap: () => context.pushNamed('match', extra: notification.path),
      ),
    );
  }
}