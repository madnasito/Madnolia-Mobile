import 'package:flutter/material.dart';
import 'package:madnolia/views/user_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class UserMatchesPage extends StatelessWidget {
  const UserMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        body: Background(
      child: SafeArea(
          child: SingleChildScrollView(
        child: UserMatchesView(),
      )),
    ));
  }
}
