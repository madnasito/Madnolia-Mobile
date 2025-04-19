import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/services/database/user_db.dart';
import 'package:madnolia/widgets/molecules/chat_message_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GroupChatMessageOrganism extends StatefulWidget {
  final String text;
  final UserDb user;
  final bool mainMessage;

  const GroupChatMessageOrganism(
      {super.key,
      required this.text,
      required this.user,
      required this.mainMessage});

  @override
  State<GroupChatMessageOrganism> createState() => _GroupChatMessageOrganismState();
}

class _GroupChatMessageOrganismState extends State<GroupChatMessageOrganism> with SingleTickerProviderStateMixin {
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
                    ? MyMessageMolecule(user: widget.user, text: widget.text, mainMessage: widget.mainMessage)
                    : NotMyMessageMolecule(user: widget.user, text: widget.text, mainMessage: widget.mainMessage),
              ),
            ),
          );
        }
      }
  
  

