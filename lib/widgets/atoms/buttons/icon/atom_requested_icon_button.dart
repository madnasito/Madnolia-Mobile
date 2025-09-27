  import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/dialogs/dialog_requested.dart';

class AtomRequestedIconButton extends StatelessWidget {

  final SimpleUser userData;

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