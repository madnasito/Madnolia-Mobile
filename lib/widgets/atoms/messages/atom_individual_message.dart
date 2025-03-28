import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/models/chat/individual_message_model.dart';

class AtomIndividualMessage extends StatefulWidget {
  final IndividualMessage message;
  const AtomIndividualMessage({super.key, required this.message});

  @override
  State<AtomIndividualMessage> createState() => _AtomIndividualMessageState();
}

class _AtomIndividualMessageState extends State<AtomIndividualMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myId = context.read<UserBloc>().state.id;
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
        child: Align(
          alignment:
              widget.message.user == myId ? Alignment.centerRight : Alignment.centerLeft,
          child: Container( // Removed Flexible
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white38, width: 0.5),
            ),
            child: Text(widget.message.text, overflow: TextOverflow.clip),
          ),
        ),
      ),
    );
  }
}