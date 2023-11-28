import 'package:flutter/material.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/form_button.dart';

import '../../widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Welcome player",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    key: formKey,
                    children: [
                      CustomInput(
                        icon: Icons.account_circle_outlined,
                        placeholder: "Username",
                        textController: emailController,
                      ),
                      CustomInput(
                          icon: Icons.lock_outline,
                          placeholder: "password",
                          textController: passwordController,
                          isPassword: true),
                      FormButton(
                          text: "Login",
                          color: const Color.fromARGB(0, 33, 149, 243),
                          onPressed: () {
                            formKey.currentState?.validate();
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Forgot password?")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
