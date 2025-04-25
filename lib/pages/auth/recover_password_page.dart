import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/background.dart';
import '../../widgets/organism/form/organism_recover_password_form.dart' show OrganismRecoverPasswordForm;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  late bool sended;

  @override
  void initState() {
    sended = false;
    super.initState();
  }
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
                  SizedBox(height: 20),
                  CenterTitleAtom(text: translate("RECOVER_PASSWORD.TITLE")),
                  SizedBox(height: 20),
                  OrganismRecoverPasswordForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}