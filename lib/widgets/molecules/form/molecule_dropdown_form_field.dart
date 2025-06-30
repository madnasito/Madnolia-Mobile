import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:madnolia/style/text_style.dart';

import '../../../style/form_style.dart';

class MoleculeDropdownFormField extends StatelessWidget {
  final String name;
  final String label;
  final int delay;
  final List<DropdownMenuItem> items;
  final dynamic initialValue;
  final IconData? icon;
  const MoleculeDropdownFormField({
    super.key,
    required this.name,
    required this.label,
    required this.items,
    required this.initialValue,
    this.delay = 300,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: delay),
      child: FormBuilderDropdown(
        dropdownColor: Colors.black38,
        name: name,
        initialValue: initialValue,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          disabledBorder: InputBorder.none,
          errorBorder: errorBorder,
          border: defaultBorder,
          focusedErrorBorder: warningBorder,
          focusedBorder: focusedBorder,
        ),
        items: items
      )
    );
  }
}