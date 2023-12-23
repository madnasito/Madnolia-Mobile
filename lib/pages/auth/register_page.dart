import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/blocs/register_provider.dart';
import 'package:Madnolia/services/auth_service.dart';
import 'package:Madnolia/views/platforms_view.dart';
import 'package:Madnolia/widgets/alert_widget.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_input_widget.dart';
import 'package:Madnolia/widgets/form_button.dart';

import '../../models/user_model.dart';

bool verifiedUser = false;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  final bloc = RegisterBloc();
  final User user =
      User(email: "", name: "", password: "", platforms: [], username: "");
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    verifiedUser = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegisterProvider(
      child: Scaffold(
        body: Background(
            child: SafeArea(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: verifiedUser ? 120 : 50),
            !verifiedUser
                ? Center(
                    child: FadeIn(
                        child: const Text("Sign up!",
                            style: TextStyle(fontSize: 40))),
                  )
                : Container(),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: !verifiedUser
                  ? FadeIn(
                      delay: const Duration(milliseconds: 500),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomInput(
                            icon: Icons.abc,
                            stream: widget.bloc.nameStream,
                            placeholder: "Name",
                            onChanged: widget.bloc.changeName,
                          ),
                          CustomInput(
                              icon: Icons.account_circle_outlined,
                              placeholder: "User name",
                              stream: widget.bloc.usernameStream,
                              onChanged: widget.bloc.changeUsername),
                          CustomInput(
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                              placeholder: "Email",
                              stream: widget.bloc.emailStream,
                              onChanged: widget.bloc.changeEmail),
                          CustomInput(
                              icon: Icons.lock_outlined,
                              placeholder: "Password",
                              isPassword: true,
                              stream: widget.bloc.passwordStream,
                              onChanged: widget.bloc.changePassword),
                        ],
                      ),
                    )
                  : Container(),
            ),
            verifiedUser
                ? PlatformsView(
                    platforms: widget.user.platforms,
                  )
                : Container(),
            FadeIn(
              delay: const Duration(seconds: 1),
              child: StreamBuilder(
                stream: widget.bloc.userValidStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return FormButton(
                      text: "Next",
                      color: Colors.transparent,
                      onPressed: (snapshot.hasData)
                          ? () => register(context, widget.bloc)
                          : null);
                },
              ),
            ),
          ]),
        ))),
      ),
    );
  }

  void register(BuildContext context, RegisterBloc bloc) async {
    final resp = await AuthService().verifyUser(bloc.username!, bloc.email!);

    if (!resp["ok"]) {
      String message = resp["message"];
      // ignore: use_build_context_synchronously
      return showAlert(context, message);
    }

    widget.user.name = bloc.name!;
    widget.user.email = bloc.email!;
    widget.user.username = bloc.username!;
    widget.user.password = bloc.password!;

    if (!verifiedUser && widget.user.platforms.isEmpty) setState(() {});

    if (verifiedUser && widget.user.platforms.isEmpty) {
      // ignore: use_build_context_synchronously
      return showAlert(context, "Select at least one platform");
    }
    verifiedUser = true;

    if (verifiedUser && widget.user.platforms.isNotEmpty) {
      final register = await AuthService().register(widget.user);

      if (register["ok"]) {
        // ignore: use_build_context_synchronously
        context.go("/");
      } else {
        // ignore: use_build_context_synchronously
        showAlert(context, "Failed sign up");
      }
    }
  }
}
