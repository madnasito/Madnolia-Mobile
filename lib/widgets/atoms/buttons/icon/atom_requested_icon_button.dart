  import 'package:flutter/material.dart';
import 'package:madnolia/database/drift/database.dart';
import 'package:madnolia/widgets/dialogs/dialog_requested.dart';

class AtomRequestedIconButton extends StatelessWidget {

  final UserData userData;

  const AtomRequestedIconButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogRequested(userData: userData);
      });
    }, icon: const Icon(Icons.check_outlined));
  }
}