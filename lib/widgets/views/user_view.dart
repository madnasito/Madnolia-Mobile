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
import 'package:image_picker/image_picker.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/utils/logout.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:madnolia/widgets/organism/form/organism_edit_user_form.dart';
import 'package:toast/toast.dart';

import '../../models/user/user_model.dart';
import '../../services/user_service.dart';
import 'package:image_cropper/image_cropper.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({super.key});

  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        CenterTitleAtom(text: translate("PROFILE.TITLE"), textStyle: neonTitleText,),
        const SizedBox(height: 10),
        _Card(
          icon: Icons.person,
          title: translate("PROFILE.YOU"),
          routeName: "/me/edit",
        ),
        // _Card(
        //   icon: Icons.bolt,
        //   title: translate("PROFILE.MATCHES"),
        //   routeName: "/me/matches",
        // ),
        _Card(
          icon: Icons.gamepad_outlined,
          title: translate("PROFILE.PLATFORMS"),
          routeName: "/me/platforms",
        ),
        // _Card(
        //   icon: Icons.group_outlined,
        //   title: translate("PROFILE.PLATFORMS"),
        //   routeName: "/user/platforms",
        // )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;
  const _Card(
      {required this.routeName, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(routeName),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 1)),
        child: ListTile(
          leading: Icon(icon, size: 30),
          title: 
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Mashetic",
                  color: Colors.white),
            ),
          trailing: Icon(Icons.arrow_forward_ios_rounded),  
        )
      ),
    );
  }
}

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

    bloc.changeName(nameController.text);
    bloc.changeEmail(emailController.text);
    bloc.changeUsername(usernameController.text);
    bloc.changeImg(userBloc.state.img);
    bloc.changeThumb(userBloc.state.thumb);

    return FutureBuilder(
      future: _loadInfo(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool uploadingImage = false;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                CenterTitleAtom(
                  text: bloc.name,
                  textStyle: neonTitleText,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(181, 255, 255, 255))),
                  child: GestureDetector(
                      onTap: () async {
                        if(uploadingImage) {
                          return;
                        }

                        uploadingImage = true;
                        final picker = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (picker != null) {


                          CroppedFile? croppedFile = await ImageCropper().cropImage(
                              sourcePath: picker.path,
                              aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                              uiSettings: [
                                AndroidUiSettings(
                                  toolbarColor: Colors.black,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio: CropAspectRatioPreset.original,
                                  cropStyle: CropStyle.circle,
                                  showCropGrid: false,
                                  hideBottomControls: true,
                                  
                                ),
                                IOSUiSettings(
                                  title: translate('PROFILE.USER_PAGE.CROP_IMAGE'),
                                  aspectRatioLockEnabled: true,
                                ),
                              ],

                              // aspectRatioPresets: [
                              //   CropAspectRatioPreset.square,
                              //   CropAspectRatioPreset.ratio3x2,
                              //   CropAspectRatioPreset.original,
                              //   CropAspectRatioPreset.ratio4x3,
                              //   CropAspectRatioPreset.ratio16x9
                              // ],
                            );
                            if(croppedFile?.path != null){
                              final resp = await bloc.uploadImage(croppedFile!.path);
                              if (resp.containsKey("img")) {
                                userBloc.updateImages(resp["img"], resp["thumb"]);
                                setState(() {
                                  
                                });
                              }else{
                                if (!context.mounted) return;
                                showErrorServerAlert(context, {"message": "NETWORK_ERROR"});
                              }
                            }
                        }

                        uploadingImage = false;
                      },
                      child: BlocBuilder(
                        bloc: userBloc,
                        builder: (context, state) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Radio muy grande para hacerla circular
                              child:  StreamBuilder(
                                  stream: bloc.imgStream,
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return CachedNetworkImage(
                                        imageUrl: userBloc.state.img,
                                        fit: BoxFit.cover, // Asegura que la imagen cubra todo el espacio
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                            ),
                        
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(9),
                                  bottomRight: Radius.circular(9),
                                )),
                              child: StreamBuilder(
                                stream: bloc.loadingStream,
                                builder:
                                    (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data == true) {
                                      return  Center(
                                        heightFactor: 2,
                                        child: Column(
                                          children: [
                                            CircularProgressIndicator(
                                              color: Colors.lightBlueAccent,
                                            ),
                                            Text(translate('PROFILE.USER_PAGE.UPLOADING_IMAGE'), style: TextStyle(color: Colors.white),)
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
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
                                backgroundImage: CachedNetworkImageProvider(userBloc.state.thumb),
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

