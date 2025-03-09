import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';

class OrganismRegisterForm extends StatelessWidget {
  const OrganismRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    // bool submitting = false;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          MoleculeTextField(
            formKey: formKey,
            name: "name",
            label: translate("REGISTER.NAME"),
            icon: Icons.abc_rounded,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.range(1, 30),
              FormBuilderValidators.alphabetical()
            ]),
          ),
          MoleculeTextField(
            formKey: formKey,
            name: "username",
            label: translate("REGISTER.USERNAME"),
            icon: Icons.account_circle_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.range(1, 30),
              FormBuilderValidators.alphabetical(regex: RegExp(r'^[a-zA-Z][-_a-zA-Z0-9.]{0,24}$'))
            ]),
          ),
          MoleculeTextField(
            formKey: formKey,
            name: "email",
            label: translate("REGISTER.EMAIL"),
            icon: Icons.account_circle_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email()
            ]),
          ),
          MoleculeTextField(
            formKey: formKey,
            name: "password",
            label: translate("REGISTER.PASSWORD"),
            icon: Icons.account_circle_outlined,
            isPassword: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.range(6, 35)
            ]),
          )
        ],
      )
    );
  }
}