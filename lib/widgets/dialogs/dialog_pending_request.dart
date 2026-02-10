import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart'
    show FlutterBackgroundService;
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/models/user/simple_user_model.dart';

class DialogPendingRequest extends StatelessWidget {
  final SimpleUser userData;
  const DialogPendingRequest({super.key, required this.userData});

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
          Text(
            t.CONNECTIONS.REQUESTS.USER_WANTS_TO_CONNECT(
              name: userData.username,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        t.CONNECTIONS.REQUESTS.ACCEPT_REQUEST,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            final backgroundService = FlutterBackgroundService();
            backgroundService.invoke('reject_connection', {
              'user': userData.id,
            });
            Navigator.pop(context, 'Reject');
          },
          child: Text(t.CONNECTIONS.REQUESTS.REJECT),
        ),
        TextButton(
          onPressed: () {
            final backgroundService = FlutterBackgroundService();
            backgroundService.invoke('accept_request', {'user': userData.id});
            Navigator.pop(context, 'OK');
          },
          child: Text(t.CONNECTIONS.REQUESTS.ACCEPT),
        ),
      ],
    );
  }
}
