import 'package:flutter/material.dart';
import 'package:Madnolia/blocs/edit_user_provider.dart';
import 'package:Madnolia/views/user_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EditUserProvider(
      child: const CustomScaffold(
          body: Background(
        child: SingleChildScrollView(
          child: EditUserView(),
        ),
      )),
    );
  }
}
