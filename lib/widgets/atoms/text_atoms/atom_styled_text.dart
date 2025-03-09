import 'package:flutter/material.dart';

class AtomStyledText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  const AtomStyledText({super.key, required this.text, required this.style, this.textAlign = TextAlign.justify});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign,);
  }
}