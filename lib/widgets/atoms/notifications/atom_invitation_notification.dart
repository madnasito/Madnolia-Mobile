import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';

import '../../../models/notification/notification_details.dart';

class AtomInvitationNotification extends StatelessWidget {
  
  final NotificationDetails data;
  final FlutterBackgroundService backgroundService;

  const AtomInvitationNotification({super.key, required this.data, required this.backgroundService});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        try {
          backgroundService.invoke('delete_notification', {'id': data.notification.id});
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
            backgroundImage: CachedNetworkImageProvider(resizeImage(data.notification.thumb)),),
          title: RichText(
            text: TextSpan(text: t.NOTIFICATIONS.INVITATION_TO_MATCH,
            children: [
              TextSpan(
                text: data.notification.title,
                style: TextStyle(fontWeight: FontWeight.bold)
              )
            ]
          ),),
          subtitle: Text("@${data.user?.username}", style: TextStyle(
              color: Colors.greenAccent,
              overflow: TextOverflow.ellipsis, // Handle long text
            )),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => context.push('/match/${data.notification.path}'),
        ),
      ),
    );
  }
}