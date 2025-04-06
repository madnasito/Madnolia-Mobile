import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CenterTitleAtom extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const CenterTitleAtom({super.key, required this.text, this.textStyle = const TextStyle(
                      fontFamily: "Cyberverse",
                      fontSize: 30,
                      )});



  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeIn(
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}