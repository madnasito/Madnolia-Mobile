import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/utils/logout.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/media/atom_profile_picture.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:madnolia/widgets/organism/form/organism_edit_user_form.dart';
import 'package:toast/toast.dart';

import '../../../models/user/user_model.dart';
import '../../../services/user_service.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({super.key});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  @override
  Widget build(BuildContext context) {
    final bloc = EditUserProvider.of(context);
    final userBloc = context.read<UserBloc>();
    ToastContext().init(context);
    final nameController = TextEditingController(text: userBloc.state.name);
    final usernameController =
        TextEditingController(text: userBloc.state.username);
    final emailController =
        TextEditingController(text: userBloc.state.email);
    final userAvailability = userBloc.state.availability;

    bloc.changeImg(userBloc.state.image);

    return FutureBuilder(
      future: _loadInfo(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                CenterTitleAtom(
                  text: userBloc.state.name,
                  textStyle: neonTitleText,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(181, 255, 255, 255)),
                  ),
                  child: 
                  AtomProfilePicture()                 
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OrganismEditUserForm(
                    updateUser: UpdateUser(
                      name: nameController.text,
                      username: usernameController.text,
                      email: emailController.text,
                      availability: userAvailability
                    )
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
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
                              Text(translate("ALERT.YOU_SURE"), textAlign: TextAlign.center),
                              const SizedBox(height: 20),
                              FormBuilder(
                                key: formKey, 
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MoleculeTextField(
                                    name: 'password',
                                    label: translate("FORM.INPUT.PASSWORD"),
                                    isPassword: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                                    ])
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), 
                              child: Text(translate('ALERT.CANCEL'))
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
                                      translate("PROFILE.USER_PAGE.ACCOUNT_DELETED"),
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
                                    // e as dynamic;
                                    // print(e.message);
                                    showErrorServerAlert(context, e.response?.data ?? {'message': 'NETWORK_ERROR'});
                                  }
                                }
                              }, 
                              child: Text(
                                translate("ALERT.DELETE_MY_ACCOUNT"), 
                                style: TextStyle(color: Colors.red),
                              )
                            )
                          ],
                        );
                      }
                    );  
                  }, 
                  child: Text(
                    translate("PROFILE.USER_PAGE.DELETE_ACCOUNT"), 
                    style: TextStyle(color: Colors.redAccent),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
              heightFactor: 15, child: CircularProgressIndicator());
        }
      },
    );
  }
}

_loadInfo(BuildContext context) async {
  final userInfo = await UserService().getUserInfo();

  if (!context.mounted) return;
  final userBloc = context.read<UserBloc>();

  userBloc.loadInfo(userFromJson(jsonEncode(userInfo)));


  return userInfo;
}

