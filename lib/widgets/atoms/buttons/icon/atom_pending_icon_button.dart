import 'package:flutter/material.dart';
import 'package:madnolia/database/drift/database.dart';
import 'package:madnolia/widgets/dialogs/dialog_pending_request.dart';

class AtomPendingIconButton extends StatelessWidget {

  final UserData userData;

  const AtomPendingIconButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogPendingRequest(userData: userData);
      });
    }, icon: const Icon(Icons.pending_outlined));
  }
}