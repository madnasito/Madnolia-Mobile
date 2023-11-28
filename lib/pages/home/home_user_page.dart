import 'package:flutter/material.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class LoggedHome extends StatelessWidget {
  const LoggedHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        body: Background(
            child: SafeArea(child: Center(child: Text("Home User")))));
  }
}
