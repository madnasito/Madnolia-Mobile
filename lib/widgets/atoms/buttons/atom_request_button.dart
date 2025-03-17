import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class AtomRequestButton extends StatelessWidget {
  final String userId;
  const AtomRequestButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      final backgroundService = FlutterBackgroundService();

      backgroundService.invoke('request_connection', {'user': userId});
    }, icon: const Icon(Icons.person_add_outlined));
  }
}