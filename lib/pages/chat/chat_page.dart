import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            color: Colors.black45,
            child: Row(
              children: [
                CachedNetworkImage(
                  errorWidget: (context, url, error) => Container(),
                  imageUrl: "https://i.beeimg.com/images/thumb/z66297834451-xs.jpg",
                  placeholderFadeInDuration: const Duration(milliseconds: 300),
                  ),
                const Column(
                  children: [
                    Text("NAME"),
                    Text("@username", style: TextStyle(fontSize: 6),)
                  ],
                ),
                Expanded(child: Container(), ),
                IconButton(
                  onPressed: () {  },
                  icon: const Icon(Icons.call_outlined),
                  ),
                  IconButton(
                  onPressed: () {  },
                  icon: const Icon(CupertinoIcons.video_camera),
                  )
              ],
            ),
          ),

        ],
      )
      );
  }
}