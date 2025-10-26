import 'package:flutter/material.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';

class AtomMessageStatusIcon extends StatelessWidget {
  final ChatMessageStatus status;
  final double? size;
  final bool pending;

  const AtomMessageStatusIcon({super.key, required this.status, this.size, required this.pending});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color? color;

    if(pending){
      icon = Icons.access_time;
      return Icon(icon, color: color, size: size ?? 16);
    }
    
    switch (status) {
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

    return Icon(icon, color: color, size: size ?? 16);
  }
}
