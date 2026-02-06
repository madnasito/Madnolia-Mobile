import 'package:flutter/material.dart';
import 'package:madnolia/widgets/views/user/view_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: Center(child: ViewSettings()));
  }
}
