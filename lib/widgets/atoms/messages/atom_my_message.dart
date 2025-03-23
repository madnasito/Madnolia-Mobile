import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AtomMyMessage extends StatelessWidget {
  final String text;
  final String thumb;
  final bool mainMessage;
  final bool groupMessage;

  const AtomMyMessage({super.key, required this.text, required this.thumb, required this.mainMessage, this.groupMessage = false});

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
                    text,
                    overflow: TextOverflow.clip,
                  ),
            ),
          ),
          groupMessage ?
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                  backgroundImage: mainMessage ? CachedNetworkImageProvider(thumb) : null,
                  backgroundColor: Colors.transparent,
              ),
            ) : const SizedBox(),
        ],
      ),
    );
  }
}