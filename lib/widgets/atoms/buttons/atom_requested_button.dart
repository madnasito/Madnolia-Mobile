import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/models/user/simple_user_model.dart';

class AtomRequestedButton extends StatelessWidget {

  final SimpleUser simpleUser;

  const AtomRequestedButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
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
      });
    }, icon: const Icon(Icons.check_outlined));
  }
}