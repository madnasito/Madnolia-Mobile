import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/scaffolds/unloged_scaffold.dart';
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
    return UnlogedScaffold(body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          SizedBox(height: 20),
          CenterTitleAtom(text: t.RECOVER_PASSWORD.TITLE),
          SizedBox(height: 20),
          OrganismRecoverPasswordForm()
        ],
      ),
    ),
  );
  }
}