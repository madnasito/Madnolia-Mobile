import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';

import '../../../services/auth_service.dart';
import '../../alert_widget.dart';

class OrganismLoginForm extends StatelessWidget {
  const OrganismLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    bool logging = false;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
        MoleculeTextField(
          formKey: formKey,
          label: translate("REGISTER.USERNAME"),
          name: "username",
          icon: Icons.person_2_outlined,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 15),
        MoleculeTextField(
          formKey: formKey,
          label: translate("REGISTER.PASSWORD"),
          name: "password",
          isPassword: true,
          icon: Icons.lock_outline_rounded,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.range(6, 35),
          ]),
        ),
        const SizedBox(height: 15),
        MoleculeFormButton(
          text: "Login",
          color: Colors.transparent,
          onPressed:(logging == false) ? () async {
            // Validate and save the form values
            formKey.currentState?.saveAndValidate();
            debugPrint(formKey.currentState?.value.toString());
            // On another side, can access all field values without saving form with instantValues
            formKey.currentState?.validate();
            debugPrint(formKey.currentState?.instantValue.toString());
            // CHecking if the form is valid before send petition
            if(!formKey.currentState!.isValid) return;
            final values = formKey.currentState?.instantValue.values.toList();
            
            logging = true;
            final Map<String, dynamic> resp = await AuthService().login(values?[0], values?[1]);
            
            if(!context.mounted) return;

            logging = false;
            
            if (resp.containsKey("error")) {
              return showErrorServerAlert(context, resp);
            } else {
              context.go("/");
            }
          } : null),
         
        ],
      ),
    );
  }
}