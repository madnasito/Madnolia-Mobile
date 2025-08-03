import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/enums/user-availability.enum.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:madnolia/widgets/alert_widget.dart' show showErrorServerAlert;
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_dropdown_form_field.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:toast/toast.dart';

import '../../../services/user_service.dart' show UserService;

class OrganismEditUserForm extends StatelessWidget {

  final UpdateUser updateUser;
  const OrganismEditUserForm({super.key, required this.updateUser});

  IconData _getIconForAvailability(UserAvailability availability) {
  switch (availability) {
    case UserAvailability.everyone: // Asumiendo que uno de tus options.name es 'available'
      return Icons.check_circle_outline;
    case UserAvailability.partners: // Asumiendo que tienes 'friendsOnly'
      return Icons.group_outlined;
    case UserAvailability.no: // Asumiendo que tienes 'doNotDisturb'
      return Icons.do_not_disturb_on_outlined;
  }
}

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final formKey = GlobalKey<FormBuilderState>();
    final availabilityOptions = [UserAvailability.everyone, UserAvailability.partners, UserAvailability.no];
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "name",
              label: translate("FORM.INPUT.NAME"),
              icon: Icons.abc_rounded,
              initialValue: updateUser.name,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.minLength(1, errorText: translate('FORM.VALIDATIONS.MIN_LENGTH', args: {'count': '1'})),
                FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'})) 
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "username",
              label: translate("FORM.INPUT.USERNAME"),
              icon: Icons.account_circle_outlined,
              initialValue: updateUser.username,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.username(errorText: translate('FORM.VALIDATIONS.USERNAME_INVALID')),
                // FormBuilderValidators.notEqual(notValidUser)
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoleculeTextField(
              name: "email",
              label: translate("FORM.INPUT.EMAIL"),
              icon: Icons.email_outlined,
              initialValue: updateUser.email,
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                FormBuilderValidators.email(errorText: translate('FORM.VALIDATIONS.INVALID_EMAIL')),
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
    label: translate('PROFILE.USER_PAGE.INVITATIONS.TITLE'),
    items: availabilityOptions.map((option) {
      // CAMBIO 2: Items con estilo neón y más visuales.
      return DropdownMenuItem(
        value: option,
        child: Row(
          children: [
            // Icono específico para cada opción
            Icon(
              _getIconForAvailability(option),
              // color: const Color(0xFF00FFFF), // Mismo color del brillo para consistencia
              // size: 22,
            ),
            const SizedBox(width: 12), // Espacio entre el ícono y el texto
            // Texto con el estilo neón que definimos
            Text(
              translate('PROFILE.USER_PAGE.INVITATIONS.${option.name.toUpperCase()}')
            ),
          ],
        ),
      );
    }).toList(),
    initialValue: updateUser.availability,
  ),
),

          StatefulBuilder(
            builder: (context, setState) =>  MoleculeFormButton(
              text: translate('PROFILE.USER_PAGE.UPDATE'),
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
            
                  Toast.show(translate("PROFILE.USER_PAGE.UPDATED"), gravity: 20, duration: 2 );
            
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