import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyMessageMolecule extends StatelessWidget {

  final String text;
  final String thumb;
  final bool mainMessage;
  const MyMessageMolecule({super.key, required this.text, required this.thumb, required this.mainMessage});

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
                backgroundImage: mainMessage ? CachedNetworkImageProvider(thumb) : null,
                backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class NotMyMessageMolecule extends StatelessWidget {

  final String thumb;
  final String text;
  final bool mainMessage;
  const NotMyMessageMolecule({super.key, required this.thumb, required this.text, required this.mainMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: CircleAvatar(backgroundImage: mainMessage ? CachedNetworkImageProvider(thumb) : null,
            backgroundColor: Colors.transparent,)
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