import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';

class AtomMyMessage extends StatelessWidget {
  final ChatMessageData messageData;
  final UserData userData;
  final bool mainMessage;

  const AtomMyMessage({super.key, required this.messageData, required this.mainMessage, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue, width: 0.5)),
              child:Text(
                    messageData.content,
                    overflow: TextOverflow.clip,
                  ),
            ),
          ),
          messageData.type != ChatMessageType.user ?
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                  backgroundImage: mainMessage ? CachedNetworkImageProvider(userData.thumb) : null,
                  backgroundColor: Colors.transparent,
              ),
            ) : const SizedBox(),
        ],
      ),
    );
  }
}