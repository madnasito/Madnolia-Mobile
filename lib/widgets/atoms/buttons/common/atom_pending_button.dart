import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/widgets/dialogs/dialog_pending_request.dart';

class AtomPendingButton extends StatelessWidget {

  final UserData userData;

  const AtomPendingButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogPendingRequest(userData: userData);
      });
    },
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: StadiumBorder(side: BorderSide(color: Colors.teal, width: 1)),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.pending_outlined),
        SizedBox(width: 8),
        Text(translate('CONNECTIONS.REQUESTS.PENDING'))
        ]
      ,)
    );
  }
}