import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AtomUserChatButton extends StatelessWidget {
  const AtomUserChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.goNamed("chat"),
      icon: const Icon(Icons.messenger_outline_sharp));
  }
}