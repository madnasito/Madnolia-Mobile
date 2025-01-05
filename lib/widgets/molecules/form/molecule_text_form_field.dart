import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../style/form_style.dart';


class MoleculeTextField extends StatelessWidget {
  final String name;
  final String label;
  final TextInputType keyboardType;
  final GlobalKey<FormBuilderState> formKey;
  final String? initialValue;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validator;
  final int delay;
  const MoleculeTextField( {
    super.key,
    required this.formKey,
    required this.name,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.isPassword = false, this.initialValue,
    this.delay = 300
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: delay),
      child: FormBuilderTextField(
        initialValue: initialValue,
        autofocus: false,
        name: name,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          errorBorder: errorBorder,
          border: defaultBorder,
          focusedErrorBorder: warningBorder,
          focusedBorder: focusedBorder,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}