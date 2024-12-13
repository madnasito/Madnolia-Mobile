import 'package:flutter/material.dart';

class StyledTextAtom extends StatelessWidget {
  final String text;
  final TextStyle style;
  const StyledTextAtom({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style,);
  }
}