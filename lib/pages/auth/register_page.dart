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

bool verifiedUser = false;
bool canScroll = false;

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
    canScroll = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final PageController controller =  PageController(
      keepPage: true,);
    bool loading = false;
    return RegisterProvider(
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: PageView(
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                if(!canScroll) controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
              },
              controller: controller,
              children: [
                FadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: OrganismRegisterForm(registerModel: widget.registerModel, controller: controller)
                    ),
                  )
                ),
                FadeIn(child: SingleChildScrollView(
                  child: OrganismSelectPlatform(registerModel: widget.registerModel)
                ))
              ],
            )
          )
        ),
      ),
    );
  }

  
}

class OrganismSelectPlatform extends StatefulWidget {
  final RegisterModel registerModel;
  const OrganismSelectPlatform({super.key, required this.registerModel});

  @override
  State<OrganismSelectPlatform> createState() => _OrganismSelectPlatformState();
}

class _OrganismSelectPlatformState extends State<OrganismSelectPlatform> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlatformsView(platforms: widget.registerModel.platforms),
        MoleculeFormButton(
          text: translate("REGISTER.TITLE"),
          isLoading: _isLoading,
          onPressed: () async {
            try {
              setState(() => _isLoading = true);
              final resp = await AuthService().register(widget.registerModel);

              if (!context.mounted) return;

              if (resp.containsKey("message")) {
                showErrorServerAlert(context, resp);
              } else {
                context.go("/");
              }
            } catch (e) {
              debugPrint(e.toString());
            } finally {
              if (mounted) setState(() => _isLoading = false);
            }
          },
        )
      ],
    );
  }
}

class OrganismRegisterForm extends StatelessWidget {
  final RegisterModel registerModel;
  final PageController controller;
  const OrganismRegisterForm({super.key, required this.registerModel, required this.controller});

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
              onChanged: (value) => canScroll = false,
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
              onChanged: (value) => canScroll = false,
              formKey: formKey,
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
              onChanged: (value) => canScroll = false,
              formKey: formKey,
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
              onChanged: (value) => canScroll = false,
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
                  canScroll = false;
                  showErrorServerAlert(context, resp);
                } else {
                  canScroll = true;
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