import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';

class AtomNotMyMessage extends StatelessWidget {
    final String thumb;
    final String text;
    final bool mainMessage;
    final bool groupMessage;
  
  const AtomNotMyMessage({super.key, required this.thumb, required this.text, required this.mainMessage, this.groupMessage = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: groupMessage ? CircleAvatar(backgroundImage: mainMessage ? CachedNetworkImageProvider(thumb) : null ,
            backgroundColor: Colors.transparent,) : const SizedBox()
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white38, width: 0.5)),
              child: Text(
                    text,
                    overflow: TextOverflow.clip,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}