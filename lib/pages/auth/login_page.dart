import 'package:Madnolia/widgets/language_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/blocs/login_provider.dart';
import 'package:Madnolia/services/auth_service.dart';
import 'package:Madnolia/widgets/alert_widget.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_input_widget.dart';
import 'package:Madnolia/widgets/form_button.dart';
import 'package:multi_language_json/multi_language_json.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    final formKey = GlobalKey<FormState>();

    LangSupport langData = LanguageBuilder.langData;

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    langData.getValue(route: ["LOGIN", "WELCOME"]),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: Text(
                    langData.getValue(route: ["LOGIN", "BUTTON"]),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  key: formKey,
                  children: [
                    CustomInput(
                      stream: bloc.usernameStream,
                      onChanged: bloc.changeEmail,
                      icon: Icons.account_circle_outlined,
                      keyboardType: TextInputType.emailAddress,
                      placeholder:
                          langData.getValue(route: ["REGISTER", "USERNAME"]),
                    ),
                    CustomInput(
                        stream: bloc.passwordStream,
                        onChanged: bloc.changePassword,
                        icon: Icons.lock_outline,
                        isPassword: true,
                        placeholder:
                            langData.getValue(route: ["REGISTER", "PASSWORD"])),
                    StreamBuilder(
                      stream: bloc.formValidStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return FormButton(
                            text: langData.getValue(route: ["LOGIN", "BUTTON"]),
                            color: const Color.fromARGB(0, 33, 149, 243),
                            onPressed: snapshot.hasData
                                ? () => _login(context, bloc)
                                : null);
                      },
                    ),
                  ],
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

  _login(BuildContext context, LoginBloc bloc) async {
    final resp = await AuthService().login(bloc.username, bloc.password);

    if (!resp["ok"]) {
      showAlert(context, resp["message"]);
    } else {
      // ignore: use_build_context_synchronously
      context.go("/");
    }
  }
}
