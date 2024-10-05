import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/models/chat_user_model.dart';
import 'package:Madnolia/widgets/molecules/chat_message_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatMessageOrganism extends StatefulWidget {
  final String text;
  final ChatUser user;
  final bool mainMessage;

  const ChatMessageOrganism(
      {super.key,
      required this.text,
      required this.user,
      required this.mainMessage});

  @override
  State<ChatMessageOrganism> createState() => _ChatMessageOrganismState();
}

class _ChatMessageOrganismState extends State<ChatMessageOrganism> with SingleTickerProviderStateMixin {
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
    final userState = context.read<UserBloc>().state; 
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Container(
          child: widget.user.id == userState.id
              ? MyMessageMolecule(text: widget.text, thumb: userState.thumb, mainMessage: widget.mainMessage)
              : NotMyMessageMolecule(thumb: userState.thumb, text: widget.text, mainMessage: widget.mainMessage),
        ),
      ),
    );
  }
}
