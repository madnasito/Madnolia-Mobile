import 'package:Madnolia/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:Madnolia/providers/user_provider.dart';

import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final ChatUser user;
  final AnimationController animationController;

  const ChatMessage(
      {super.key,
      required this.text,
      required this.user,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserProvider>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Container(
          child: user.username == userService.user.username
              ? _myMessage(userService.user)
              : _notMyMessage(user),
        ),
      ),
    );
  }

  Widget _myMessage(user) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10, left: 50, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${user.name}\n",
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.pinkAccent),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    text,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.thumbImg),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notMyMessage(ChatUser user) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(user.thumbImg)),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10, left: 5, right: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white38, width: 0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.username}\n",
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.greenAccent),
                  ),
                  Text(
                    text,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
