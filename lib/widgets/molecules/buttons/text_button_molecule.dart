import 'package:flutter/material.dart';
import 'package:madnolia/widgets/atoms/text_atoms/styled_text_atom.dart';

class TextButtonMolecule extends StatelessWidget {
  final String text;
  final ButtonStyle buttonStyle;
  final TextStyle textStye;
  final void Function() onPressed;
  const TextButtonMolecule({super.key, required this.onPressed, required this.text, required this.textStye, required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: buttonStyle,
      onPressed: onPressed, child: StyledTextAtom(text: text, style: textStye),
    );
  }
}