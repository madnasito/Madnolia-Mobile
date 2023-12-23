import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const NotificationButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Theme.of(context).shadowColor,
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
