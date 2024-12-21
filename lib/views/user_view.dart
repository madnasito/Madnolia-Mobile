import 'dart:convert';

import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madnolia/blocs/edit_user_bloc.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';
import 'package:toast/toast.dart';

import '../models/user/user_model.dart';
import '../services/user_service.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({super.key});

  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);
    return Column(
      children: [
        _Card(
          icon: Icons.person,
          title: translate("PROFILE.YOU"),
          routeName: "/user/edit",
        ),
        _Card(
          icon: Icons.bolt,
          title: translate("PROFILE.MATCHES"),
          routeName: "/user/matches",
        ),
        _Card(
          icon: Icons.gamepad_outlined,
          title: translate("PROFILE.PLATFORMS"),
          routeName: "/user/platforms",
        )
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
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 3)),
        child: Column(
          children: [
            Icon(icon),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Cyberverse",
                  color: Colors.white),
            )
          ],
        ),
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

    final nameController = TextEditingController(text: userBloc.state.name);
    final usernameController =
        TextEditingController(text: userBloc.state.username);
    final emailController =
        TextEditingController(text: userBloc.state.email);

    bloc.changeName(nameController.text);
    bloc.changeEmail(emailController.text);
    bloc.changeUsername(usernameController.text);
    bloc.changeImg(userBloc.state.img);
    bloc.changeThumb(userBloc.state.thumb);

    int acceptInvitations = userBloc.state.availability;
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
                Text(
                  bloc.name,
                  style: const TextStyle(fontSize: 20),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
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
                          final resp = await bloc.uploadImage(picker);
                          if (resp.containsKey("img")) {
                            userBloc.updateImages(resp["img"], resp["thumb"]);
                            setState(() {
                              
                            });
                          }else{
                            if (!context.mounted) return;
                            showErrorServerAlert(context, {"message": "NETWORK_ERROR"});
                          }
                        }

                        uploadingImage = false;
                      },
                      child: BlocBuilder(
                        bloc: userBloc,
                        builder: (context, state) => Stack(
                          children: [
                            StreamBuilder(
                              stream: bloc.imgStream,
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return CachedNetworkImage(imageUrl: userBloc.state.img);
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                        
                            StreamBuilder(
                              stream: bloc.loadingStream,
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == true) {
                                    return const Center(
                                      heightFactor: 2,
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.lightBlueAccent,
                                          ),
                                          Text("Updating img")
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
                            //  const Center(
                            //       heightFactor: 2,
                            //       child: Column(
                            //         children: [
                            //           CircularProgressIndicator(
                            //             color: Colors.lightBlueAccent,
                            //           ),
                            //           Text("Updating img")
                            //         ],
                            //       ),
                            //     )
                            // : Container()
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                CustomInput(
                    controller: nameController,
                    icon: Icons.abc,
                    placeholder: translate("PROFILE.USER_PAGE.NAME"),
                    stream: bloc.nameStream,
                    onChanged: bloc.changeName),
                CustomInput(
                    icon: Icons.account_circle_outlined,
                    placeholder: translate("PROFILE.USER_PAGE.USERNAME"),
                    stream: bloc.usernameStream,
                    onChanged: bloc.changeUsername,
                    controller: usernameController),
                CustomInput(
                    icon: Icons.email_outlined,
                    placeholder: translate("PROFILE.USER_PAGE.EMAIL"),
                    stream: bloc.emailStream,
                    onChanged: bloc.changeEmail,
                    controller: emailController),
                // DropDownWidget(
                //   value: userBloc.state.availability,
                //   onChanged: (value) {
                //     acceptInvitations = value as int;
                //   },
                // ),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: bloc.userValidStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return FormButton(
                        text: translate("PROFILE.USER_PAGE.UPDATE"),
                        color: const Color.fromARGB(0, 33, 149, 243),
                        onPressed: snapshot.hasData
                            ? () => _uptadeUser(
                                bloc, userBloc, acceptInvitations)
                            : null);
                  },
                ),
                const SizedBox(height: 20)
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

_uptadeUser(
    EditUserBloc bloc, UserBloc userBloc, int invitations) async {
    
    
  UpdateUser user = UpdateUser(
      email: bloc.email,
      name: bloc.name,
      username: bloc.username,
      availability: 1);
  Map<String, dynamic> resp = await UserService().updateUser(user);

  if (resp.containsKey("error")) {
    return Toast.show("Error");
  }

  Toast.show("Updated user", gravity: 20, duration: 2 );
  final User newUser = User.fromJson(resp);

  userBloc.loadInfo(newUser);

}
