import 'package:flutter/material.dart';
import 'package:madnolia/blocs/provider.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

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
                          stream: bloc.emailStream,
                          onChanged: bloc.changeEmail,
                          icon: Icons.email_outlined,
                          placeholder: "Email"),
                      CustomInput(
                          stream: bloc.passwordStream,
                          onChanged: bloc.changePassword,
                          icon: Icons.lock_outline,
                          placeholder: "Password"),
                      StreamBuilder(
                        stream: bloc.formValidStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return FormButton(
                              text: "Login",
                              color: const Color.fromARGB(0, 33, 149, 243),
                              onPressed:
                                  snapshot.hasData ? () => _login(bloc) : null);
                        },
                      ),
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

  _login(LoginBloc bloc) {
    print("===========");
    print("Email: ${bloc.email}");
    print("Password: ${bloc.password}");
    print("===========");
  }
}
