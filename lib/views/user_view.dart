import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Madnolia/blocs/edit_user_bloc.dart';
import 'package:Madnolia/blocs/edit_user_provider.dart';
import 'package:Madnolia/services/upload_service.dart';
import 'package:Madnolia/widgets/custom_input_widget.dart';
import 'package:Madnolia/widgets/form_button.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Card(
          icon: Icons.person,
          title: "You",
          routeName: "/user/edit",
        ),
        _Card(
          icon: Icons.bolt,
          title: "Matches",
          routeName: "/user/matches",
        ),
        _Card(
          icon: Icons.gamepad_outlined,
          title: "Platforms",
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
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Cyberverse",
                  color: Colors.greenAccent),
            )
          ],
        ),
      ),
    );
  }
}

class EditUserView extends StatelessWidget {
  const EditUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = EditUserProvider.of(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final nameController = TextEditingController(text: userProvider.user.name);
    final usernameController =
        TextEditingController(text: userProvider.user.username);
    final emailController =
        TextEditingController(text: userProvider.user.email);

    bloc.changeName(nameController.text);
    bloc.changeEmail(emailController.text);
    bloc.changeUsername(usernameController.text);
    bloc.changeImg(userProvider.user.img.toString());
    bloc.changeThumbImg(userProvider.user.thumbImg.toString());

    String acceptInvitations = userProvider.user.acceptInvitations.toString();
    return FutureBuilder(
      future: _loadInfo(userProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                Text(
                  userProvider.user.name,
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
                        final picker = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (picker != null) {
                          final resp = await bloc.uploadImage(picker);
                          if (resp["ok"]) {
                            userProvider.user.img = resp["img"];
                            userProvider.user.img = resp["thumb_img"];
                          }
                        }
                      },
                      child: Stack(
                        children: [
                          StreamBuilder(
                            stream: bloc.imgStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Image.network(bloc.img,
                                    colorBlendMode: BlendMode.darken,
                                    color: null);
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
                      )),
                ),
                const SizedBox(height: 20),
                CustomInput(
                    controller: nameController,
                    icon: Icons.abc,
                    placeholder: "Name",
                    stream: bloc.nameStream,
                    onChanged: bloc.changeName),
                CustomInput(
                    icon: Icons.account_circle_outlined,
                    placeholder: "User name",
                    stream: bloc.usernameStream,
                    onChanged: bloc.changeUsername,
                    controller: usernameController),
                CustomInput(
                    icon: Icons.email_outlined,
                    placeholder: "Email",
                    stream: bloc.emailStream,
                    onChanged: bloc.changeEmail,
                    controller: emailController),
                DropDownWidget(
                  value: userProvider.user.acceptInvitations.toString(),
                  onChanged: (value) {
                    acceptInvitations = value.toString();
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: bloc.userValidStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return FormButton(
                        text: "Update",
                        color: const Color.fromARGB(0, 33, 149, 243),
                        onPressed: snapshot.hasData
                            ? () => _uptadeUser(
                                bloc, userProvider, acceptInvitations)
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

_loadInfo(UserProvider user) async {
  final userInfo = await UserService().getUserInfo();

  user.user = userFromJson(jsonEncode(userInfo));

  return userInfo;
}

_uptadeUser(
    EditUserBloc bloc, UserProvider provider, String invitations) async {
  User user = User(
      email: bloc.email,
      name: bloc.name,
      platforms: [],
      username: bloc.username,
      acceptInvitations: invitations);
  Map<String, dynamic> resp = await UserService().updateUser(user);

  final newUser = User.fromJson(resp);

  provider.user = newUser;
}
