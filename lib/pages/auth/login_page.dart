import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/login_provider.dart';
import 'package:madnolia/services/auth_service.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    final formKey = GlobalKey<FormState>();

bool logging = false;
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
                    translate('LOGIN.WELCOME'),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: Text(
                    translate("LOGIN.BUTTON"),
                    style: const TextStyle(fontSize: 40),
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
                          translate("REGISTER.USERNAME"),
                    ),
                    CustomInput(
                        stream: bloc.passwordStream,
                        onChanged: bloc.changePassword,
                        icon: Icons.lock_outline,
                        isPassword: true,
                        placeholder:
                            translate("REGISTER.PASSWORD")),
                    StreamBuilder(
                      stream: bloc.formValidStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        
                        return FormButton(
                            text: translate("LOGIN.BUTTON"),
                            color: const Color.fromARGB(0, 33, 149, 243),
                            onPressed: (snapshot.hasData && !logging)
                                ? () => _login(context, bloc, logging)
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

  _login(BuildContext context, LoginBloc bloc, bool logging) async {
    logging = true;
    final Map resp = await AuthService().login(bloc.username, bloc.password);

    logging = false;
    if (resp.containsKey("error")) {
      return showErrorServerAlert(context, resp);
    } else {
      // ignore: use_build_context_synchronously
      context.go("/");
    }
  }
}
