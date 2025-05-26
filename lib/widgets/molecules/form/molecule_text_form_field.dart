import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../style/form_style.dart';


class MoleculeTextField extends StatelessWidget {
  final String name;
  final String label;
  final TextInputType keyboardType;
  final String? initialValue;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validator;
  final int delay;
  final bool enabled;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final Function(String?)? onChanged;
  final Function()? onTap;
  const MoleculeTextField( {
    super.key,
    required this.name,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.readOnly = false,
    this.isPassword = false, this.initialValue,
    this.delay = 300,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: delay),
      child: FormBuilderTextField(
        onChanged: onChanged,
        enabled:enabled ,
        initialValue: initialValue,
        autofocus: false,
        name: name,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          disabledBorder: InputBorder.none,
          errorBorder: errorBorder,
          border: defaultBorder,
          focusedErrorBorder: warningBorder,
          focusedBorder: focusedBorder,
        ),
        autovalidateMode: autovalidateMode,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
      ),
    );
  }
}