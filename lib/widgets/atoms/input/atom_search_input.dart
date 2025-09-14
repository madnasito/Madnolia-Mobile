import 'package:flutter/material.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';

class AtomSearchInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController searchController;
  final Function(String) onChanged;
  const AtomSearchInput({super.key, required this.placeholder, required this.searchController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SimpleCustomInput(
      placeholder: placeholder,
      controller: searchController,
      iconData: Icons.search,
      autofocus: true,
      onChanged: onChanged,
    );
  }
}