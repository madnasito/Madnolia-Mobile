import 'package:flutter/material.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_pending_button.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_request_button.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_requested_button.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_user_chat_button.dart';

class MoleculeConnectionButton extends StatelessWidget {

  final SimpleUser userData;
  
  const MoleculeConnectionButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    switch (userData.connection) {
      case ConnectionStatus.none:
        return AtomRequestButton(userId: userData.id,);
      case ConnectionStatus.requestSent:
        return AtomRequestedButton(userData: userData,);
      case ConnectionStatus.requestReceived:
        return AtomPendingButton(userData: userData);
      case ConnectionStatus.partner:
        return AtomUserChatButton(user: ChatUser(
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