import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/enums/user-availability.enum.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:madnolia/utils/get_availability_data.dart';
import 'package:madnolia/widgets/alert_widget.dart' show showErrorServerAlert;
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_dropdown_form_field.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:toast/toast.dart';

import '../../../services/user_service.dart' show UserService;

class OrganismEditUserForm extends StatelessWidget {

  
  const OrganismEditUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final formKey = GlobalKey<FormBuilderState>();
    final availabilityOptions = [UserAvailability.everyone, UserAvailability.partners, UserAvailability.no];
    final userBloc = context.read<UserBloc>();
    ToastContext().init(context);
    final nameController = TextEditingController(text: userBloc.state.name);
    final usernameController =
        TextEditingController(text: userBloc.state.username);
    final emailController =
        TextEditingController(text: userBloc.state.email);
    final userAvailability = userBloc.state.availability;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "name",
              label: t.FORM.INPUT.NAME,
              icon: Icons.abc_rounded,
              initialValue: nameController.text,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: t.FORM.VALIDATIONS.REQUIRED),
                FormBuilderValidators.minLength(1, errorText: translate('FORM.VALIDATIONS.MIN_LENGTH', args: {'count': '1'})),
                FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'})) 
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "username",
              label: t.FORM.INPUT.USERNAME,
              icon: Icons.account_circle_outlined,
              initialValue: usernameController.text,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: t.FORM.VALIDATIONS.REQUIRED),
                FormBuilderValidators.username(errorText: t.FORM.VALIDATIONS.USERNAME_INVALID),
                // FormBuilderValidators.notEqual(notValidUser)
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "email",
              label: t.FORM.INPUT.EMAIL,
              icon: Icons.email_outlined,
              initialValue: emailController.text,
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: t.FORM.VALIDATIONS.REQUIRED),
                FormBuilderValidators.email(errorText: t.FORM.VALIDATIONS.INVALID_EMAIL),
                // FormBuilderValidators.notEqual(notValidEmail)
              ])
            ),
          ),
          Padding(
  padding: const EdgeInsets.only(bottom: 16),
  child: MoleculeDropdownFormField(
    // CAMBIO 1: Ícono principal más adecuado.
    // icon: Icons.shield, // O Icons.visibility, o Icons.toggle_on
    
    name: 'availability',
    label: t.PROFILE.USER_PAGE.INVITATIONS.TITLE,
    items: availabilityOptions.map((option) {
      // CAMBIO 2: Items con estilo neón y más visuales.
      return DropdownMenuItem(
        value: option,
        child: Row(
          children: [
            // Icono específico para cada opción
            Icon(
              getIconForAvailability(option),
              // color: const Color(0xFF00FFFF), // Mismo color del brillo para consistencia
              // size: 22,
            ),
            const SizedBox(width: 12), 
            Text(
              t.PROFILE.USER_PAGE.INVITATIONS.${option.name.toUpperCase()}
            ),
          ],
        ),
      );
    }).toList(),
    initialValue: userAvailability,
  ),
),

          StatefulBuilder(
            builder: (context, setState) =>  MoleculeFormButton(
              text: t.PROFILE.USER_PAGE.UPDATE,
              isLoading: loading,
              onPressed: () async {
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
                  final UserAvailability availability = formKey.currentState!.fields['availability']?.transformedValue;
            
                  final UpdateUser user = UpdateUser(name: name, username: username, email: email, availability: availability);
                  final newUser = await UserService().updateUser(user);
                  
                  if(!context.mounted) return;
                  final userBloc = context.read<UserBloc>();
                  final platformGamesBloc = context.read<PlatformGamesBloc>();
            
                  Toast.show(t.PROFILE.USER_PAGE.UPDATED, gravity: 20, duration: 2 );
            
                  userBloc.loadInfo(newUser);
                  
                  if(platformGamesBloc.state.platformGames.isEmpty) platformGamesBloc.add(LoadPlatforms(platforms: userBloc.state.platforms));

                  debugPrint(availability.toString());
                } catch (e) {
                 if (context.mounted) {
                  showErrorServerAlert(context, e as Map);
                } 
                } finally {
                  if (context.mounted) {
                  setState(() => loading = false);
                }
                }
                
                  
              },
            ),
          )
        ],
      )
    );
  }
}