import 'package:flutter/material.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:madnolia/widgets/views/user/view_my_profile.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EditUserProvider(
      child: SingleChildScrollView(child: ViewMyProfile()),
    );
  }
}
