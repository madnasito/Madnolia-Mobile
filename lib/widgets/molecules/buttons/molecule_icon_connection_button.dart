import 'package:flutter/material.dart';
import 'package:madnolia/database/drift/database.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import '../../atoms/buttons/atom_buttons.dart';


class MoleculeConnectionIconButton extends StatelessWidget {
  final UserData userData;
  const MoleculeConnectionIconButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    switch (userData.connection) {
      case ConnectionStatus.none:
        return AtomRequestIconButton(userId: userData.id,);
      case ConnectionStatus.requestSent:
        return AtomRequestedIconButton(userData: userData,);
      case ConnectionStatus.requestReceived:
        return AtomPendingIconButton(userData: userData);
      case ConnectionStatus.partner:
        return AtomUserChatIconButton(user: ChatUser(
          id: userData.id,
          name: userData.name,
          thumb: userData.thumb,
          username: userData.username
          )
        );
      case ConnectionStatus.blocked:
        return const SizedBox();
    }
  }
}