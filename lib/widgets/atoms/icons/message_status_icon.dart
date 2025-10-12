import 'package:flutter/material.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';

class AtomMessageStatusIcon extends StatelessWidget {
  final ChatMessageStatus status;

  const AtomMessageStatusIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color? color;

    switch (status) {
      case ChatMessageStatus.queued:
        icon = Icons.access_time;
        break;
      case ChatMessageStatus.sent:
        icon = Icons.done;
        break;
      case ChatMessageStatus.delivered:
        icon = Icons.done_all;
        break;
      case ChatMessageStatus.read:
        icon = Icons.done_all;
        color = Colors.blue;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Icon(icon, color: color, size: 16);
  }
}
