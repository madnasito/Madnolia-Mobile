import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/models/chat_user_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final ChatUser user;
  final AnimationController animationController;
  final bool mainMessage;

  const ChatMessage(
      {super.key,
      required this.text,
      required this.user,
      required this.animationController, required this.mainMessage});

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Container(
          child: user.username == userState.username
              ? _myMessage(userState, mainMessage)
              : _notMyMessage(user, mainMessage),
        ),
      ),
    );
  }

  Widget _myMessage(UserState user, bool mainMessage) {
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
                backgroundImage: mainMessage ? NetworkImage(user.thumb) : null,
                backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _notMyMessage(ChatUser user, bool mainMessage) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: CircleAvatar(backgroundImage: mainMessage ? NetworkImage(user.thumb) : null, backgroundColor: Colors.transparent,)
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
