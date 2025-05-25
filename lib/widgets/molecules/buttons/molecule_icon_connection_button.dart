import 'package:flutter/material.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import '../../atoms/buttons/atom_buttons.dart';


class MoleculeConnectionIconButton extends StatelessWidget {
  final SimpleUser simpleUser;
  const MoleculeConnectionIconButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    switch (simpleUser.connection) {
      case ConnectionStatus.none:
        return AtomRequestIconButton(userId: simpleUser.id,);
      case ConnectionStatus.requestSent:
        return AtomRequestedIconButton(simpleUser: simpleUser,);
      case ConnectionStatus.requestReceived:
        return AtomPendingIconButton(simpleUser: simpleUser);
      case ConnectionStatus.partner:
        return AtomUserChatIconButton(user: ChatUser(
          id: simpleUser.id,
          name: simpleUser.name,
          thumb: simpleUser.thumb,
          username: simpleUser.username
          )
        );
      case ConnectionStatus.blocked:
        return const SizedBox();
    }
  }
}