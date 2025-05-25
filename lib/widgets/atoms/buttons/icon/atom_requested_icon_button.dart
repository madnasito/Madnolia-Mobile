  import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/dialogs/dialog_requested.dart';

class AtomRequestedIconButton extends StatelessWidget {

  final SimpleUser simpleUser;

  const AtomRequestedIconButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogRequested(simpleUser: simpleUser);
      });
    }, icon: const Icon(Icons.check_outlined));
  }
}