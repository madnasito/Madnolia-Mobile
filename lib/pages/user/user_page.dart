import 'package:flutter/material.dart';
import 'package:madnolia/widgets/views/user/view_user.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: Center(child: ViewUser()));
  }
}
