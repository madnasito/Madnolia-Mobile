import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/models/chat_user_model.dart';
import 'package:Madnolia/widgets/molecules/chat_message_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatMessageOrganism extends StatelessWidget {
  final String text;
  final ChatUser user;
  final AnimationController animationController;
  final bool mainMessage;

  const ChatMessageOrganism(
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
          child: user.id == userState.id
              ? MyMessageMolecule(text: text, thumb: userState.thumb, mainMessage: mainMessage)
              : NotMyMessageMolecule(thumb: userState.thumb, text: text, mainMessage: mainMessage),
        ),
      ),
    );
  }

}
