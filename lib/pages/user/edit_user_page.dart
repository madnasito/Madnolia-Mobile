import 'package:flutter/material.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:madnolia/widgets/views/user/user_view.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EditUserProvider(
      child: const CustomScaffold(
          body: SingleChildScrollView(
          child: EditUserView(),
        ),
      ),
    );
  }
}
