import 'package:flutter/material.dart';

class StyledTextAtom extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  const StyledTextAtom({super.key, required this.text, required this.style, this.textAlign = TextAlign.justify});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign,);
  }
}