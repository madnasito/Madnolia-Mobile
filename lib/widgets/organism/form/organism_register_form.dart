import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
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
  
  const OrganismRegisterForm({
    super.key, 
    required this.registerModel, 
    required this.controller, 
    required this.changeScroll
  });

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final formKey = GlobalKey<FormBuilderState>();
    
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
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
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.minLength(1, errorText: translate('FORM.VALIDATIONS.MIN_LENGTH', args: {'count': '1'})),
                FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'})) 
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              // onChanged: (value) => changeScroll(false),
              name: "username",
              label: translate("FORM.INPUT.USERNAME"),
              icon: Icons.account_circle_outlined,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.username(errorText: translate('FORM.VALIDATIONS.USERNAME_INVALID')),
                FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'})) 
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
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.email(errorText: translate('FORM.VALIDATIONS.INVALID_EMAIL')),
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
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.minLength(6, errorText: translate('FORM.VALIDATIONS.MIN_LENGTH', args: {'count': '6'})),
                FormBuilderValidators.maxLength(40, errorText: translate('FORM.VALIDATIONS.INVALID_LENGTH')) 
              ]),
            ),
          ),
            
          StatefulBuilder(
            builder: (context, setState) => MoleculeFormButton(
              text: translate("REGISTER.NEXT"),
              isLoading: loading,
              onPressed: () async {
                try {
                  setState(() => loading = true);
                  FocusScope.of(context).unfocus();
                  formKey.currentState?.validate();
                  
                  // Valida el formulario
                  if (!formKey.currentState!.validate()) {
                    setState(() => loading = false);
                    changeScroll(false); // Mantiene scroll deshabilitado
                    return;
                  }

                  final String name = formKey.currentState!.fields['name']?.value;
                  final String username = formKey.currentState!.fields['username']?.value;
                  final String email = formKey.currentState!.fields['email']?.value;
                  final String password = formKey.currentState!.fields['password']?.value;

                  final resp = await AuthService().verifyUser(username, email);

                  if (resp.containsKey("message") && context.mounted) {
                    changeScroll(false); // Deshabilita scroll si hay error
                    showErrorServerAlert(context, resp);
                  } else {
                    changeScroll(true); // Habilita scroll si es exitoso
                    registerModel.name = name;
                    registerModel.email = email;
                    registerModel.password = password;
                    registerModel.username = username;
                    
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    changeScroll(false);
                    showAlert(context, e.toString());
                  }
                } finally {
                  if (context.mounted) {
                    setState(() => loading = false);
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            FadeIn(delay: const Duration(milliseconds: 400),child: Text(translate("REGISTER.SUBTITLE"))),
            const SizedBox(width: 5),
            FadeIn(delay: const Duration(milliseconds: 450),child: GestureDetector(
              onTap: () => context.goNamed('login'),
              child: Text(translate("REGISTER.SUB_LOGIN"), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),))),
                      ]
                      ,)
        ],
      ),
    );
  }
}