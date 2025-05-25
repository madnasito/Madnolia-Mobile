import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/dialogs/dialog_pending_request.dart';

class AtomPendingIconButton extends StatelessWidget {

  final SimpleUser simpleUser;

  const AtomPendingIconButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogPendingRequest(simpleUser: simpleUser);
      });
    }, icon: const Icon(Icons.pending_outlined));
  }
}