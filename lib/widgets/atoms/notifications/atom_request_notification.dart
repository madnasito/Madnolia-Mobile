import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart' show FlutterBackgroundService;
import 'package:madnolia/i18n/strings.g.dart';
import '../../../models/notification/notification_details.dart';

class AtomRequestNotification extends StatelessWidget {

  final NotificationDetails data;
  const AtomRequestNotification({super.key, required this.data});

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
          backgroundImage: CachedNetworkImageProvider(data.notification.thumb),),
        title: Text(t.NOTIFICATIONS.CONNECTION_REQUEST(name: data.notification.title)),
        subtitle: Text("@${data.user?.username}", style: TextStyle(
            color: Colors.greenAccent, // Lighter grey for subtitle
            overflow: TextOverflow.ellipsis, // Handle long text
          )),
        trailing: Icon(Icons.more_vert_rounded),
        onTap: () => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding:  EdgeInsets.only(bottom: 10, top: 20),
          actionsPadding: const EdgeInsets.all(0),
          titleTextStyle: const TextStyle(fontSize: 20),
          title: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(data.user!.thumb),
              ),
              const SizedBox(height: 20),
              Text(t.NOTIFICATIONS.CONNECTION_REQUEST(name: data.user!.name), textAlign: TextAlign.center,),
              SizedBox(height: 8,),
              Text("@${data.user?.username}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 158, 157, 80)),)
            ],
          ),
          content:  Text(t.NOTIFICATIONS.ACCEPT_REQUEST_TITLE, textAlign: TextAlign.center,),
          actions: [
            TextButton(
              onPressed: () {
                final backgroundService = FlutterBackgroundService();
                backgroundService.invoke('reject_connection', {'user': data.user?.id});
                Navigator.pop(context, 'Cancel');
              } ,
              child: Text(t.UTILS.REJECT, style: TextStyle(color: Colors.redAccent)),
            ),
              TextButton(
                onPressed: () {
                  final backgroundService = FlutterBackgroundService();
                  backgroundService.invoke('accept_connection', {'user': data.user?.id});
                  Navigator.pop(context, 'OK');
                  },
                child: Text(t.UTILS.ACCEPT, style: TextStyle(color: Colors.greenAccent)),
              ),
          ],
        );
      }),
    ),
  );
  }
}