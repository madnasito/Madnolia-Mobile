import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MoleculeFormButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  const MoleculeFormButton({super.key, required this.text, this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: onPressed != null
                  ? const BorderSide(color: Colors.blue, width: 2)
                  : null,
              foregroundColor: Colors.blue,
              shadowColor: Colors.black,
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
          )),
    );
  }
}