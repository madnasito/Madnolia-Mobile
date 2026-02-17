import 'package:madnolia/database/database.dart';
import 'package:madnolia/widgets/molecules/chat_message_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/blocs.dart';

class GroupChatMessageOrganism extends StatelessWidget {
  final ChatMessageData messageData;
  final UserData user;
  final bool isFirst;
  final bool isLast;

  const GroupChatMessageOrganism({
    super.key,
    required this.messageData,
    required this.user,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;

    return user.id == userState.id
        ? MyGroupMessageMolecule(
            user: user,
            messageData: messageData,
            isFirst: isFirst,
            isLast: isLast,
          )
        : NotMyGroupMessageMolecule(
            user: user,
            messageData: messageData,
            isFirst: isFirst,
            isLast: isLast,
          );
  }
}
