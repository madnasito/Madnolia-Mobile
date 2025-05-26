import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart' show CenterTitleAtom;
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';

import '../../../models/auth/register_model.dart' show RegisterModel;
import '../../../services/auth_service.dart' show AuthService;
import '../../alert_widget.dart' show showAlert, showErrorServerAlert;
import '../../molecules/form/molecule_text_form_field.dart';

class OrganismRegisterForm extends StatelessWidget {
  final RegisterModel registerModel;
  final PageController controller;
  final void Function(bool) changeScroll;
  const OrganismRegisterForm({super.key, required this.registerModel, required this.controller, required this.changeScroll});

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          CenterTitleAtom(text: translate("REGISTER.TITLE")),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              onChanged: (value) => changeScroll(false),
              name: "name",
              label: translate("FORM.INPUT.NAME"),
              icon: Icons.abc_rounded,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.maxLength(20) 
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              onChanged: (value) => changeScroll(false),
              name: "username",
              label: translate("FORM.INPUT.USERNAME"),
              icon: Icons.account_circle_outlined,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.username(),
                // FormBuilderValidators.notEqual(notValidUser)
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              onChanged: (value) => changeScroll(false),
              name: "email",
              label: translate("FORM.INPUT.EMAIL"),
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
                // FormBuilderValidators.notEqual(notValidEmail)
              ])
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              onChanged: (value) => changeScroll(false),
              name: "password",
              label: translate("FORM.INPUT.PASSWORD"),
              icon: Icons.lock_outline_rounded,
              isPassword: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.maxLength(100) 
              ]),
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) =>  MoleculeFormButton(
              text: translate("REGISTER.NEXT"),
              isLoading: loading,
              onPressed:() async {
                 try {
                setState(() => loading = true);
                
                formKey.currentState?.validate();
                if (!formKey.currentState!.isValid) {
                  setState(() => loading = false);
                  return;
                }

                final String name = formKey.currentState!.fields['name']?.transformedValue;
                final String username = formKey.currentState!.fields['username']?.transformedValue;
                final String email = formKey.currentState!.fields['email']?.transformedValue;
                final String password = formKey.currentState!.fields['password']?.transformedValue;

                final resp = await AuthService().verifyUser(username, email);

                if (resp.containsKey("message") && context.mounted) {
                  changeScroll(false);
                  showErrorServerAlert(context, resp);
                } else {
                  changeScroll(true);
                  registerModel.name = name;
                  registerModel.email = email;
                  registerModel.password = password;
                  registerModel.username = username;
                  controller.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceIn,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  showAlert(context, e.toString());
                }
              } finally {
                if (context.mounted) {
                  setState(() => loading = false);
                }
              }
              } ),
          )
        ],
      ),
    );
  }
}