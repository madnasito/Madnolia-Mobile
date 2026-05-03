import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../enums/events/user-events.enum.dart';

class AtomRequestIconButton extends StatelessWidget {
  final String userId;
  const AtomRequestIconButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final backgroundService = FlutterBackgroundService();

        backgroundService.invoke(UserEvents.requestConnection.event, {
          'user': userId,
        });
      },
      icon: const Icon(Icons.person_add_outlined),
    );
  }
}
