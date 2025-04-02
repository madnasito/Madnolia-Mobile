import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AtomUserChatButton extends StatelessWidget {
    final String userId;
  const AtomUserChatButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pushNamed("user_chat", extra: userId),
      icon: const Icon(Icons.messenger_outline_sharp));
  }
}