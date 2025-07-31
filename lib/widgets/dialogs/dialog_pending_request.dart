import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart' show FlutterBackgroundService;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/user/simple_user_model.dart';

class DialogPendingRequest extends StatelessWidget {
  final SimpleUser simpleUser;
  const DialogPendingRequest({super.key, required this.simpleUser});

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
            backgroundImage: CachedNetworkImageProvider(simpleUser.thumb),
          ),
          const SizedBox(height: 20),
          Text(translate('CONNECTIONS.REQUESTS.USER_WANTS_TO_CONNECT', args: {'name': simpleUser.username}), textAlign: TextAlign.center,)
        ],
      ),
      content: Text(translate('CONNECTIONS.REQUESTS.ACCEPT_REQUEST'), textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () {
            final backgroundService = FlutterBackgroundService();
            backgroundService.invoke('reject_connection', {'user': simpleUser.id});
            Navigator.pop(context, 'Reject');
          } ,
          child: Text(translate('CONNECTIONS.REQUESTS.REJECT')),
        ),
          TextButton(
            onPressed: () {
              final backgroundService = FlutterBackgroundService();
              backgroundService.invoke('accept_connection', {'user': simpleUser.id});
              Navigator.pop(context, 'OK');
              },
            child: Text(translate('CONNECTIONS.REQUESTS.ACCEPT')),
          ),
      ],
    );
  }
}