import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/models/auth/register_model.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/register_provider.dart';
import 'package:madnolia/services/auth_service.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart' show MoleculeTextField;
import 'package:madnolia/widgets/views/platforms_view.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';

bool verifiedUser = false;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  final bloc = RegisterBloc();
  final RegisterModel registerModel =
      RegisterModel(email: "", name: "", password: "", platforms: [], username: "");
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    verifiedUser = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return RegisterProvider(
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: verifiedUser ? 120 : 50),
                  !verifiedUser
                      ? CenterTitleAtom(text: translate("REGISTER.TITLE"))
                      : Container(),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: !verifiedUser
                        ? FadeIn(
                            delay: const Duration(milliseconds: 500),
                            child: OrganismRegisterForm()
                          )
                        : Container(),
                  ),
                  verifiedUser
                      ? PlatformsView(
                          platforms: widget.registerModel.platforms,
                        )
                      : Container(),
                  FadeIn(
                    delay: const Duration(seconds: 1),
                    child: StreamBuilder(
                      stream: widget.bloc.userValidStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return FormButton(
                            text: translate("REGISTER.NEXT"),
                            color: Colors.transparent,
                            onPressed: (snapshot.hasData)
                                ? () => register(context, widget.bloc)
                                : null);
                      },
                    ),
                  ),
                ]
              ),
            )
          )
        ),
      ),
    );
  }

  void register(
      BuildContext context, RegisterBloc bloc, ) async {
    final Map resp = await AuthService().verifyUser(bloc.username!, bloc.email!);
    if(!context.mounted) return;
    if (resp.containsKey("error") && context.mounted) {
      return showErrorServerAlert(context, resp);
    }

    widget.registerModel.name = bloc.name!;
    widget.registerModel.email = bloc.email!;
    widget.registerModel.username = bloc.username!;
    widget.registerModel.password = bloc.password!;

    if (!verifiedUser && widget.registerModel.platforms.isEmpty) setState(() {});

    if (verifiedUser && widget.registerModel.platforms.isEmpty) {
      return showAlert(
        context,
        translate("CREATE_MATCH.PLATFORMS_EMPTY"),
      );
    }
    verifiedUser = true;

    if (verifiedUser && widget.registerModel.platforms.isNotEmpty) {
      final Map<String, dynamic> register = await AuthService().register(widget.registerModel);
      if(!context.mounted) return;
      if (register.containsKey("user")) {
        context.go("/");
      } else {
        showErrorServerAlert(context, register);
      }
    }
   }
}

class OrganismRegisterForm extends StatelessWidget {
  const OrganismRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    String notValidUser = "";
    String notValidEmail = '';
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              formKey: formKey,
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
              formKey: formKey,
              name: "username",
              label: translate("FORM.INPUT.USERNAME"),
              icon: Icons.account_circle_outlined,
              onChanged: (String? value) {
                
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.username(),
                FormBuilderValidators.notEqual('madna')
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              formKey: formKey,
              name: "email",
              label: translate("FORM.INPUT.EMAIL"),
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email()
              ]),
              onChanged: (value) {
                print(value);
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              formKey: formKey,
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
          MoleculeFormButton(
            text: translate("REGISTER.NEXT"),
            onPressed: _loading == false ? () async {
              // On another side, can access all field values without saving form with instantValues
              formKey.currentState?.validate();
              debugPrint(formKey.currentState?.instantValue.toString());
              // CHecking if the form is valid before send petition
              if(!formKey.currentState!.isValid) return;
              final values = formKey.currentState?.instantValue.values.toList();

              final String name = formKey.currentState!.fields['name']?.transformedValue;
              final String username = formKey.currentState!.fields['username']?.transformedValue;
              final String email = formKey.currentState!.fields['email']?.transformedValue;
              final String password = formKey.currentState!.fields['password']?.transformedValue;

              print(values);
          } : null,)
        ],
      ),
    );
  }
}