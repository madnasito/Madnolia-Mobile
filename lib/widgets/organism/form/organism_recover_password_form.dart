import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart' show FormBuilder, FormBuilderState;
import 'package:madnolia/i18n/strings.g.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/services/mail_service.dart' show MailService;
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:toastification/toastification.dart';

class OrganismRecoverPasswordForm extends StatefulWidget {
  const OrganismRecoverPasswordForm({super.key});

  @override
  State<OrganismRecoverPasswordForm> createState() => _OrganismRecoverPasswordFormState();
}

class _OrganismRecoverPasswordFormState extends State<OrganismRecoverPasswordForm> {
  bool _isLoading = false; // Estado para controlar la carga
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          MoleculeTextField(
            keyboardType: TextInputType.emailAddress,
            name: "email",
            label: t.REGISTER.EMAIL,
            icon: Icons.email_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(errorText: t.FORM.VALIDATIONS.INVALID_EMAIL)
            ]),
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
          SizedBox(height: 20),
          MoleculeFormButton(
            text: t.RECOVER_PASSWORD.RECOVER_PASSWORD, 
            color: Colors.transparent, 
            isLoading: _isLoading, // Pasamos el estado de carga al botón
            onPressed: () async {
              try {
                //Simple to use, no global configuration
                setState(() => _isLoading = true);
                
                formKey.currentState?.saveAndValidate();
                debugPrint(formKey.currentState?.value.toString());
                formKey.currentState?.validate();
                debugPrint(formKey.currentState?.instantValue.toString());
                
                if(!formKey.currentState!.isValid) {
                  setState(() => _isLoading = false);
                  return;
                }
                
                final values = formKey.currentState?.instantValue.values.toList();
                final Map<String, dynamic> resp = await MailService().restorePassword(values?[0]);

                if(!context.mounted) {
                  setState(() => _isLoading = false);
                  return;
                }
                
                if (resp.containsKey("error")) {
                  setState(() => _isLoading = false);
                  showErrorServerAlert(context, resp);
                } else {
                  setState(() => _isLoading = false);
                  formKey.currentState?.reset();
                  toastification.show(
                    context: context, // optional if you use ToastificationWrapper
                    title: Text(t.RECOVER_PASSWORD.EMAIL_SENDED),
                    autoCloseDuration: const Duration(seconds: 5),
                    style: ToastificationStyle.fillColored,
                  );
                }
              } catch (e) {
                setState(() => _isLoading = false);
                if(e is Map) showErrorServerAlert(context, e); 
              }
            },
          )
        ],
      )
    );
  }
}