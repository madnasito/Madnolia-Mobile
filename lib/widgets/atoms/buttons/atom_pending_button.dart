import 'package:flutter/material.dart';

class AtomPendingButton extends StatelessWidget {
  const AtomPendingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){}, icon: const Icon(Icons.pending_outlined));
  }
}