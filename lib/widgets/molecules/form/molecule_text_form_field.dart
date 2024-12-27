import 'package:flutter/material.dart';

import '../../../style/form_style.dart';


class MoleculeTextField extends StatelessWidget {
  final IconData? icon;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPassword;
  final Key formKey;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  const MoleculeTextField({super.key, this.icon, required this.placeholder, required this.keyboardType, required this.isPassword, required this.onChanged, this.validator, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        hintText: placeholder,
        errorBorder: errorBorder,
        // enabledBorder: snapshot.hasData ? validBorder : null,
        focusedErrorBorder: warningBorder,
        focusedBorder: focusedBorder,
        ),
      autovalidateMode: AutovalidateMode.always,
      validator: validator,

    );
  }
}