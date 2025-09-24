import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';


class DialogRequested extends StatelessWidget {
  final UserData userData;
  const DialogRequested({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.only(bottom: 10, top: 20),
      actionsPadding: const EdgeInsets.all(0),
      titleTextStyle: const TextStyle(fontSize: 20),
      title: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(userData.thumb),
          ),
          const SizedBox(height: 20),
          Text(translate('CONNECTIONS.HAVE_A_REQUEST', args: {'name': userData.name}), textAlign: TextAlign.center,)
        ],
      ),
      content: Text(translate('CONNECTIONS.REQUESTS.WANT_TO_CANCELL'), textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          } ,
          child: Text(translate('UTILS.DISMISS')),
        ),
          TextButton(
            onPressed: () {
              final backgroundService = FlutterBackgroundService();
              backgroundService.invoke('cancel_connection', {'user': userData.id});
              Navigator.pop(context);
              },
            child: Text(translate('CONNECTIONS.REQUESTS.CANCEL')),
          ),
      ],
    );
  }
}