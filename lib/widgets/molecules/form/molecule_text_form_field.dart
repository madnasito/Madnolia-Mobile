import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../style/form_style.dart';

class MoleculeTextField extends StatefulWidget {
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
  final EdgeInsetsGeometry? contentPadding;
  final Function(String?)? onChanged;
  final Function()? onTap;

  const MoleculeTextField({
    super.key,
    required this.name,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.contentPadding,
    this.readOnly = false,
    this.isPassword = false,
    this.initialValue,
    this.delay = 300,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onTap,
  });

  @override
  State<MoleculeTextField> createState() => _MoleculeTextFieldState();
}

class _MoleculeTextFieldState extends State<MoleculeTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: widget.delay),
      child: FormBuilderTextField(
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        autofocus: false,
        name: widget.name,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          labelText: widget.label,
          disabledBorder: InputBorder.none,
          errorBorder: errorBorder,
          border: defaultBorder,
          focusedErrorBorder: warningBorder,
          focusedBorder: focusedBorder,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
      ),
    );
  }
}