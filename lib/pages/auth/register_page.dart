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
import 'package:madnolia/widgets/form_button.dart';

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
                    child: OrganismRegisterForm(registerModel: widget.registerModel, controller: controller,),
                  )
                ),
                FadeIn(child: SingleChildScrollView(
                  child: PlatformsView(platforms: widget.registerModel.platforms),
                ))
              ],
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
          MoleculeFormButton(
            text: translate("REGISTER.NEXT"),
            isLoading: loading,
            onPressed: () async {
              // On another side, can access all field values without saving form with instantValues
              loading = true;
              formKey.currentState?.validate();
              debugPrint(formKey.currentState?.instantValue.toString());
              // CHecking if the form is valid before send petition
              if(!formKey.currentState!.isValid) return;
              final values = formKey.currentState?.instantValue.values.toList();

              if(!formKey.currentState!.isValid) {
                loading = false;
                return;
              };

              final String name = formKey.currentState!.fields['name']?.transformedValue;
              final String username = formKey.currentState!.fields['username']?.transformedValue;
              final String email = formKey.currentState!.fields['email']?.transformedValue;
              final String password = formKey.currentState!.fields['password']?.transformedValue;

              final resp = await AuthService().verifyUser(username, email);


              loading = false;
              if(resp.containsKey("error") && context.mounted) {
                return showErrorServerAlert(
                  context,
                  resp,
                );
              }

              canScroll = true;
              
              registerModel.name = name;
              registerModel.email = email;
              registerModel.password = password;
              registerModel.username = username;
              controller.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
          } )
        ],
      ),
    );
  }
}