import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart' show FlutterBackgroundService;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/users/user.services.dart';
import 'package:madnolia/models/notification/notification_model.dart';

class AtomRequestNotification extends StatelessWidget {

  final NotificationModel notification;
  const AtomRequestNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final userDbServices = UserDbServices();
    return FutureBuilder(
      future: userDbServices.getUserById(notification.sender),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return  Container(
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
                title: Text(translate('NOTIFICATIONS.CONNECTION_REQUEST', args: {'name': notification.title})),
                subtitle: Text("@${snapshot.data?.username}", style: TextStyle(
                    color: Colors.greenAccent, // Lighter grey for subtitle
                    overflow: TextOverflow.ellipsis, // Handle long text
                  )),
                trailing: Icon(Icons.more_vert_rounded),
                onTap: () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                final UserData simpleUser = snapshot.data!;
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
                      Text(translate('NOTIFICATIONS.CONNECTION_REQUEST', args: {'name': simpleUser.name}), textAlign: TextAlign.center,),
                      SizedBox(height: 8,),
                      Text("@${simpleUser.username}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 158, 157, 80)),)
                    ],
                  ),
                  content:  Text(translate('NOTIFICATIONS.ACCEPT_REQUEST_TITLE'), textAlign: TextAlign.center,),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final backgroundService = FlutterBackgroundService();
                        backgroundService.invoke('reject_connection', {'user': simpleUser.id});
                        Navigator.pop(context, 'Cancel');
                      } ,
                      child: Text(translate('UTILS.REJECT'), style: TextStyle(color: Colors.redAccent)),
                    ),
                      TextButton(
                        onPressed: () {
                          final backgroundService = FlutterBackgroundService();
                          backgroundService.invoke('accept_connection', {'user': simpleUser.id});
                          Navigator.pop(context, 'OK');
                          },
                        child: Text(translate('UTILS.ACCEPT'), style: TextStyle(color: Colors.greenAccent)),
                      ),
                  ],
                );
              }),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}