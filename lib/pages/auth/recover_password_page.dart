import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import '../../widgets/organism/form/organism_recover_password_form.dart'
    show OrganismRecoverPasswordForm;

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CenterTitleAtom(text: t.RECOVER_PASSWORD.TITLE),
          const SizedBox(height: 20),
          const OrganismRecoverPasswordForm(),
        ],
      ),
    );
  }
}
