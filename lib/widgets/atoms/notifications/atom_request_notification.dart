import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/notification/notification_model.dart';
import 'package:madnolia/utils/user_db_util.dart';

class AtomRequestNotification extends StatelessWidget {

  final NotificationModel notification;
  const AtomRequestNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDb(notification.sender),
      builder: (context, snapshot) {
        if(snapshot.hasData){ 
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
              subtitle: Text("@${snapshot.data?.username}", style: TextStyle(
                  color: Colors.greenAccent,
                  overflow: TextOverflow.ellipsis, // Handle long text
                )),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: () => context.pushNamed('match', extra: notification.path),
            ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
      
    );
  }
}