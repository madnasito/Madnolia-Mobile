import 'package:flutter/material.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/views/user/view_user.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        body: SingleChildScrollView(
          child: Center(child: ViewUser()
        )
      )
    );
  }
}
