import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:toast/toast.dart';

import '../../services/user_service.dart';
import '../../utils/logout.dart';
import '../molecules/form/molecule_text_form_field.dart';

class OrganismDeleteAccountButton extends StatelessWidget {
  const OrganismDeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return MaterialButton(
      onPressed: () async {
        showDialog(
          context: context, 
          builder: (BuildContext context) { 
            final formKey = GlobalKey<FormBuilderState>();
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              contentPadding: EdgeInsets.only(bottom: 10, top: 20),
              actionsPadding: const EdgeInsets.all(0),
              titleTextStyle: const TextStyle(fontSize: 20),
              title: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(userBloc.state.image),
                  ),
                  const SizedBox(height: 20),
                  Text('@${userBloc.state.username}', textAlign: TextAlign.center),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(t.ALERT.YOU_SURE, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  FormBuilder(
                    key: formKey, 
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MoleculeTextField(
                        name: 'password',
                        label: t.FORM.INPUT.PASSWORD,
                        isPassword: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: t.FORM.VALIDATIONS.REQUIRED),
                        ])
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(t.ALERT.CANCEL)
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      // Validate and save the form values
                      if (!formKey.currentState!.validate()) return;
                      
                      formKey.currentState!.save();
                      final String password = formKey.currentState!.value['password'] ?? '';

                      final resp = await UserService().deleteUser(password);
                      
                      if (!context.mounted) return;

                      // Corrección aquí: verifica correctamente la respuesta
                      if (resp['ok'] == true) {
                        Toast.show(
                          t.PROFILE.USER_PAGE.ACCOUNT_DELETED,
                          gravity: 20,
                          border: Border.all(color: Colors.red, width: 2),
                          duration: 5
                        );
                        
                        Navigator.pop(context); // Cierra el diálogo primero
                        logoutApp(context);
                        Timer(Duration(seconds: 1), () {
                          if (context.mounted) {
                            context.go('/');
                          }
                        });
                      } else {
                        // Muestra error si la contraseña es incorrecta u otro error
                        showErrorServerAlert(context, resp);
                      }
                    } catch (e) {
                      
                      // debugPrint(e.runtimeType as String?);
                      if (context.mounted && e is DioException) {
                        showErrorServerAlert(context, e.response?.data ?? {'message': 'NETWORK_ERROR'});
                      }
                    }
                  }, 
                  child: Text(
                    t.ALERT.DELETE_MY_ACCOUNT, 
                    style: TextStyle(color: Colors.red),
                  )
                )
              ],
            );
          }
        );  
      }, 
      child: Text(
        t.PROFILE.USER_PAGE.DELETE_ACCOUNT, 
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}