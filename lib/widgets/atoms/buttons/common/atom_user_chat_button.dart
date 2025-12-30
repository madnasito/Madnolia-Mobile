import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/chat_user_model.dart';

class AtomUserChatButton extends StatelessWidget {

  final ChatUser user;
  const AtomUserChatButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.pushNamed("user-chat", extra: user),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: StadiumBorder(side: BorderSide(color: Colors.teal, width: 1)),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.chat_bubble_outline_rounded),
        SizedBox(width: 8),
        Text(t.CHAT.MESSAGES)
        ]
      ,)
     );
  }
}