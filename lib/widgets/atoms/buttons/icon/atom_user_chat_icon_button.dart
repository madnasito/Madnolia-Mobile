import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/chat_user_model.dart';

class AtomUserChatIconButton extends StatelessWidget {
    final ChatUser user;
  const AtomUserChatIconButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pushNamed("user-chat", extra: user),
      icon: const Icon(Icons.messenger_outline_sharp));
  }
}