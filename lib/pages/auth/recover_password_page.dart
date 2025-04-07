import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/services/mail_service.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';

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
    return CustomScaffold(body: Column(
      children: [
        SizedBox(height: 20),
        CenterTitleAtom(text: "Recover your password"),
        SizedBox(height: 20),
        OrganismRecoverPasswordForm()
      ],
    ));
  }
}

class OrganismRecoverPasswordForm extends StatefulWidget {
  const OrganismRecoverPasswordForm({super.key});

  @override
  State<OrganismRecoverPasswordForm> createState() => _OrganismRecoverPasswordFormState();
}

class _OrganismRecoverPasswordFormState extends State<OrganismRecoverPasswordForm> {
  bool _isLoading = false; // Estado para controlar la carga

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          MoleculeTextField(
            formKey: formKey,
            keyboardType: TextInputType.emailAddress,
            name: "email",
            label: "Email",
            icon: Icons.email_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email()
            ]),
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
          SizedBox(height: 20),
          MoleculeFormButton(
            text: 'Recover password', 
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
                  showDialog(
                    context: context, 
                    builder: (context) => Center(
                      child: AlertDialog(
                        icon: Icon(Icons.check_circle_outline_rounded),
                        iconColor: Colors.greenAccent,
                        title: Text('Email Sended!'),
                        backgroundColor: Colors.black54,
                      ),
                    )
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