import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  const FormButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 5),
            foregroundColor: Colors.blue,
            shadowColor: Colors.black,
            textStyle: const TextStyle(color: Colors.white),
            elevation: 2,
            backgroundColor: color,
            shape: const StadiumBorder()),
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ));
  }
}
