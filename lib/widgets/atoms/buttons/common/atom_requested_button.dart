import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/dialogs/dialog_requested.dart' show DialogRequested;

class AtomRequestedButton extends StatelessWidget {

  final SimpleUser userData;
  
  const AtomRequestedButton({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogRequested(userData: userData);
      });
    },
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: StadiumBorder(side: BorderSide(color: Colors.green, width: 1)),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Icon(Icons.check_rounded),
          SizedBox(width: 8),
          Text(translate('CONNECTIONS.REQUESTS.REQUESTED'))
          ]
        ,)
      ,
    );
  }
}