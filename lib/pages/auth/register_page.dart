import 'package:flutter/material.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Background(
          child: SafeArea(
              child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: formKey,
            children: [
              CustomInput(
                  icon: Icons.abc_outlined,
                  placeholder: "placeholder",
                  textController: nameController)
            ]),
      ))),
    );
  }
}
