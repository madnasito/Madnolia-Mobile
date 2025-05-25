import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class AtomRequestButton extends StatelessWidget {

  final String userId;
  
  const AtomRequestButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        final backgroundService = FlutterBackgroundService();

        backgroundService.invoke('request_connection', {'user': userId});
      },
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: StadiumBorder(side: BorderSide(color: Colors.lightBlueAccent, width: 1)),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Icon(Icons.person_add_alt),
          SizedBox(width: 8),
          Text('Add')
        ]
      )
    );
  }
}