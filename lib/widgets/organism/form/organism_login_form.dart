import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
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
            label: t.FORM.INPUT.USERNAME_EMAIL,
            name: "username",
            icon: Icons.person_2_outlined,
            onChanged: (value) {
              final trimmed = value?.replaceAll(' ', '');
              FormBuilder.of(context)?.fields['username']?.didChange(trimmed);
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: t.FORM.VALIDATIONS.REQUIRED,
              ),
            ]),
          ),
          const SizedBox(height: 15),
          MoleculeTextField(
            label: t.REGISTER.PASSWORD,
            name: "password",
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: t.FORM.VALIDATIONS.REQUIRED,
              ),
              FormBuilderValidators.maxLength(
                40,
                errorText: t.FORM.VALIDATIONS.INVALID_LENGTH,
              ),
            ]),
          ),
          const SizedBox(height: 15),
          StatefulBuilder(
            builder: (BuildContext context, setState) => MoleculeFormButton(
              text: t.HEADER.LOGIN,
              isLoading: logging,
              color: Colors.transparent,
              onPressed: (logging == false)
                  ? () async {
                      try {
                        setState(() => logging = true);
                        // Validate and save the form values
                        formKey.currentState?.saveAndValidate();
                        debugPrint(formKey.currentState?.value.toString());
                        // On another side, can access all field values without saving form with instantValues
                        formKey.currentState?.validate();
                        debugPrint(
                          formKey.currentState?.instantValue.toString(),
                        );
                        // CHecking if the form is valid before send petition
                        if (!formKey.currentState!.isValid) return;
                        final values = formKey.currentState?.instantValue.values
                            .toList();

                        if (!formKey.currentState!.isValid) {
                          setState(() => logging = false);
                          return;
                        }
                        final Map<String, dynamic> resp = await AuthService()
                            .login(values?[0], values?[1]);

                        if (!context.mounted) return;

                        if (resp.containsKey("error")) {
                          return showErrorServerAlert(context, resp);
                        } else {
                          if (context.mounted) {
                            context.read<UserBloc>().add(GetInfo());
                            context.read<UserBloc>().add(
                              WatchUnreadNotifications(),
                            );
                            context.go("/");
                          }
                        }
                      } catch (e) {
                        if (context.mounted) showAlert(context, e.toString());
                      } finally {
                        if (context.mounted) {
                          setState(() => logging = false);
                        }
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
