import 'package:flutter/material.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import '../../atoms/buttons/atom_buttons.dart';


class MoleculeConnectionButton extends StatelessWidget {
  final SimpleUser simpleUser;
  const MoleculeConnectionButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    switch (simpleUser.connection) {
      case ConnectionStatus.none:
        return AtomRequestButton(userId: simpleUser.id,);
      case ConnectionStatus.requestSent:
        return const AtomRequestedButton();
      case ConnectionStatus.requestReceived:
        return const AtomPendingButton();
      case ConnectionStatus.partner:
        return const AtomUserChatButton();
      case ConnectionStatus.blocked:
        return const SizedBox();
    }
  }
}