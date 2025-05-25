import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../models/user/simple_user_model.dart';

class DialogRequested extends StatelessWidget {
  final SimpleUser simpleUser;
  const DialogRequested({super.key, required this.simpleUser});

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
          Text('You have requested a connection to ${simpleUser.name}', textAlign: TextAlign.center,)
        ],
      ),
      content: const Text('Do you want to cancell it?', textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          } ,
          child: const Text('Dismiss'),
        ),
          TextButton(
            onPressed: () {
              final backgroundService = FlutterBackgroundService();
              backgroundService.invoke('cancel_connection', {'user': simpleUser.id});
              Navigator.pop(context);
              },
            child: const Text('Cancel request'),
          ),
      ],
    );
  }
}