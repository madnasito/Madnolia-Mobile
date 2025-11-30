import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/services/auth_service.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:toastification/toastification.dart';

import '../../molecules/buttons/molecule_form_button.dart' show MoleculeFormButton;

class OrganismRecoverPasswordTokenForm extends StatefulWidget {
  final String token;
  const OrganismRecoverPasswordTokenForm({super.key, required this.token});

  @override
  State<OrganismRecoverPasswordTokenForm> createState() => _OrganismRecoverPasswordTokenFormState();
}

class _OrganismRecoverPasswordTokenFormState extends State<OrganismRecoverPasswordTokenForm> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          MoleculeTextField(
            label: translate("FORM.INPUT.NEW_PASSWORD"),
            name: "password",
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
              FormBuilderValidators.minLength(6, errorText: translate('FORM.VALIDATIONS.MIN_LENGTH', args: {'count': '6'})),
              FormBuilderValidators.maxLength(40, errorText: translate('FORM.VALIDATIONS.INVALID_LENGTH')) 
            ])
          ),
          SizedBox(height: 15),
          MoleculeFormButton(
            text: translate("FORM.BUTTONS.UPDATE_PASSWORD"), 
            color: Colors.transparent, 
            isLoading: _isLoading, // Pasamos el estado de carga al botón
            onPressed: () async {
              try {
                setState(() => _isLoading = true);
                
                formKey.currentState?.saveAndValidate();
                debugPrint(formKey.currentState?.value.toString());
                formKey.currentState?.validate();
                debugPrint(formKey.currentState?.instantValue.toString());
                
                if(!formKey.currentState!.isValid) {
                  setState(() => _isLoading = false);
                  return;
                }
                
                final value = formKey.currentState?.instantValue.values.toList()[0];
                Map<String, String> body = {
                  "password": value,
                };
                final Map<String, dynamic> resp = await AuthService().updatePassword(
                  body: body,
                  token: widget.token
                );

                if(!context.mounted) {
                  setState(() => _isLoading = false);
                  return;
                }
                
                if (resp.containsKey("error")) {
                  setState(() => _isLoading = false);
                  showErrorServerAlert(context, resp);
                } else {
                  if(resp.containsKey('token')){
                    setState(() => _isLoading = false);
                    final storage = FlutterSecureStorage();
                    await storage.write(key: 'token', value: resp['token']);

                    await storage.write(key: "userId", value: resp["user"]["_id"]);
                
                    // Inicializar y iniciar el servicio
                    await AuthService().initializeAndStartService();

                    if(!context.mounted) return;
                    toastification.show(
                      context: context, // optional if you use ToastificationWrapper
                      title: Text(translate("RECOVER_PASSWORD.PASSWORD_UPDATED")),
                      autoCloseDuration: const Duration(seconds: 5),
                      style: ToastificationStyle.fillColored,
                    );
                    Timer(const Duration(seconds: 2), () => GoRouter.of(context).go('/home-user'));
                  }
                }
              } catch (e) {
                setState(() => _isLoading = false);
                if(context.mounted) if(e is DioException) showErrorServerAlert(context, {'message': e.message}); 
              }
            },
          )
        ]
      )
  
    );
  }
}