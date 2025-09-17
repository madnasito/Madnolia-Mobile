import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/notification/notification_model.dart';
import 'package:madnolia/database/services/user-db.service.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';

class AtomInvitationNotification extends StatelessWidget {
  final NotificationModel notification;
  final NotificationsService notificationsService;
  const AtomInvitationNotification({super.key, required this.notification, required this.notificationsService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDb(notification.sender),
      builder: (context, snapshot) {
        if(snapshot.hasData){ 
          return Dismissible(
            key: UniqueKey(),
            confirmDismiss: (direction) async {
              try {
                await notificationsService.deleteNotification(notification.id);
                return true;
              } catch (e) {
                return false;
              }
            },
            direction: DismissDirection.startToEnd,
            background: Container(
              decoration: BoxDecoration(gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomCenter,
              colors: [Color.fromARGB(186, 255, 31, 15), Colors.transparent])
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.delete_outline_rounded, size: 40,)),
            ),
            onDismissed: (direction) {

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45, // Darker background
                borderRadius: BorderRadius.circular(12), // Optional rounded corners
              ),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), 
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[800],
                  backgroundImage: CachedNetworkImageProvider(resizeImage(notification.thumb)),),
                title: RichText(
                  text: TextSpan(text: translate("NOTIFICATIONS.INVITATION_TO_MATCH"),
                  children: [
                    TextSpan(
                      text: notification.title,
                      style: TextStyle(fontWeight: FontWeight.bold)
                    )
                  ]
                ),),
                subtitle: Text("@${snapshot.data?.username}", style: TextStyle(
                    color: Colors.greenAccent,
                    overflow: TextOverflow.ellipsis, // Handle long text
                  )),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () => context.push('/match/${notification.path}'),
              ),
                ),
          );
            } else {
              return CircularProgressIndicator();
            }
          }
      
    );
  }
}