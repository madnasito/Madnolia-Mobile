import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/organism/form/organism_login_form.dart';

import '../../widgets/atoms/text_atoms/center_title_atom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  CenterTitleAtom(text: translate("LOGIN.BUTTON"),),
                  const SizedBox(height: 30),

                  const OrganismLoginForm(),

                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => context.pushNamed('recover-password'),
                    child: FadeIn(delay: const Duration(milliseconds: 350),child: Text(translate("LOGIN.FORGOT_PASSWORD"), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue), ), )),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    FadeIn(delay: const Duration(milliseconds: 400),child: Text(translate("LOGIN.SUBTITLE"))),
                    const SizedBox(width: 5),
                    FadeIn(delay: const Duration(milliseconds: 450),child: GestureDetector(
                      onTap: () => context.goNamed('register'),
                      child: Text(translate("LOGIN.SUB_REGISTER"), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),))),
                  ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
