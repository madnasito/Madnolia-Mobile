import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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

class AtomNotificationTile extends StatelessWidget {
  const AtomNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
    );
  }
}