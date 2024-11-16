// ignore_for_file: use_build_context_synchronously

import 'package:madnolia/models/auth/register_model.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/register_provider.dart';
import 'package:madnolia/services/auth_service.dart';
import 'package:madnolia/views/platforms_view.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';

bool verifiedUser = false;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  final bloc = RegisterBloc();
  final RegisterModel registerModel =
      RegisterModel(email: "", name: "", password: "", platforms: [], username: "");
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
                        child: Text(
                            translate("REGISTER.TITLE"),
                            style: const TextStyle(fontSize: 40))),
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
                            placeholder: translate("REGISTER.NAME"),
                            onChanged: widget.bloc.changeName,
                          ),
                          CustomInput(
                              icon: Icons.account_circle_outlined,
                              placeholder: translate("REGISTER.USERNAME" ),
                              stream: widget.bloc.usernameStream,
                              onChanged: widget.bloc.changeUsername),
                          CustomInput(
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                              placeholder: translate("REGISTER.EMAIL") ,
                              stream: widget.bloc.emailStream,
                              onChanged: widget.bloc.changeEmail),
                          CustomInput(
                              icon: Icons.lock_outlined,
                              placeholder: translate("REGISTER.PASSWORD") ,
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
                    platforms: widget.registerModel.platforms,
                  )
                : Container(),
            FadeIn(
              delay: const Duration(seconds: 1),
              child: StreamBuilder(
                stream: widget.bloc.userValidStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return FormButton(
                      text: translate("REGISTER.NEXT"),
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

  void register(
      BuildContext context, RegisterBloc bloc, ) async {
    final Map resp = await AuthService().verifyUser(bloc.username!, bloc.email!);

    if (resp.containsKey("error")) {
      return showErrorServerAlert(context, resp);
    }

    widget.registerModel.name = bloc.name!;
    widget.registerModel.email = bloc.email!;
    widget.registerModel.username = bloc.username!;
    widget.registerModel.password = bloc.password!;

    if (!verifiedUser && widget.registerModel.platforms.isEmpty) setState(() {});

    if (verifiedUser && widget.registerModel.platforms.isEmpty) {
      return showAlert(
        context,
        translate("CREATE_MATCH.PLATFORMS_EMPTY"),
      );
    }
    verifiedUser = true;

    if (verifiedUser && widget.registerModel.platforms.isNotEmpty) {
      final Map<String, dynamic> register = await AuthService().register(widget.registerModel);

      if (register.containsKey("user")) {
        context.go("/");
      } else {
        
        showErrorServerAlert(context, register);
      }
    }
   }
}
