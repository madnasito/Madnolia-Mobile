import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import '../../widgets/organism/input/organism_chat_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {

    // String userId; 
    // if (GoRouterState.of(context).extra != null) {
    //   if (GoRouterState.of(context).extra is String) {
    //     userId = GoRouterState.of(context).extra as String;
    //   }
    // } else{
    //   context.go('/');
    // }
    return CustomScaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
            color: Colors.black45,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider("https://i.beeimg.com/images/thumb/z66297834451-xs.jpg"),
                  radius: 30,
                ),
                const Column(
                  children: [
                    Text("NAME"),
                    Text("@username", style: TextStyle(fontSize: 6),)
                  ],
                ),
                Expanded(child: Container() ),
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
          Flexible(child: ListView.builder(
            itemCount: 0,
            itemBuilder: (_, i) => Container())),
          const OrganismChatInput()
        ],
      )
      );
  }
}