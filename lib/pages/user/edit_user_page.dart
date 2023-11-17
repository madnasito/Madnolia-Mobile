import 'package:flutter/material.dart';
import 'package:madnolia/views/user_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Background(
      child: SingleChildScrollView(
        child: EditUserView(),
      ),
    ));
  }
}
