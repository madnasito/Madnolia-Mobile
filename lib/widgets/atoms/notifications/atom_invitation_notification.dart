import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/notification/notification_model.dart';
import 'package:madnolia/models/user/simple_user_model.dart';

class AtomInvitationNotification extends StatelessWidget {
  final NotificationModel notification;
  const AtomInvitationNotification({super.key, required this.notification});

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
        onTap: () => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final SimpleUser simpleUser = SimpleUser(id: notification.path, name: notification.title, username: notification.subtitle, thumb: notification.thumb, connection: ConnectionStatus.requestReceived);
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding:  EdgeInsets.only(bottom: 10, top: 20),
          actionsPadding: const EdgeInsets.all(0),
          titleTextStyle: const TextStyle(fontSize: 20),
          title: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(simpleUser.thumb),
              ),
              const SizedBox(height: 20),
              Text('${simpleUser.name} wants to connect with you', textAlign: TextAlign.center,)
            ],
          ),
          content: const Text('Accept request?', textAlign: TextAlign.center,),
          actions: [
            TextButton(
              onPressed: () {
                final backgroundService = FlutterBackgroundService();
                backgroundService.invoke('reject_connection', {'user': simpleUser.id});
                Navigator.pop(context, 'Cancel');
              } ,
              child: const Text('Cancel'),
            ),
              TextButton(
                onPressed: () {
                  final backgroundService = FlutterBackgroundService();
                  backgroundService.invoke('accept_connection', {'user': simpleUser.id});
                  Navigator.pop(context, 'OK');
                  },
                child: const Text('Accept'),
              ),
          ],
        );
      }),
      ),
    );
  }
}