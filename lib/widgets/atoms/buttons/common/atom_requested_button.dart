import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/dialogs/dialog_requested.dart' show DialogRequested;

class AtomRequestedButton extends StatelessWidget {

  final SimpleUser simpleUser;
  
  const AtomRequestedButton({super.key, required this.simpleUser});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: (){
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return DialogRequested(simpleUser: simpleUser);
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
          Text('Requested')
          ]
        ,)
      ,
    );
  }
}