import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../style/form_style.dart';


class MoleculeTextField extends StatelessWidget {
  final String name;
  final String label;
  final TextInputType keyboardType;
  final GlobalKey<FormBuilderState> formKey;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validator;
  const MoleculeTextField( {
    super.key,
    required this.formKey,
    required this.name,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 300),
      child: FormBuilderTextField(
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