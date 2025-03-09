import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/cubits/match_users/match_users_cubit.dart';
import 'package:madnolia/main.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'custom_input_widget.dart';

class SeatchUser extends StatefulWidget {
  const SeatchUser({super.key});

  @override
  State<SeatchUser> createState() => _SeatchUserState();
}

class _SeatchUserState extends State<SeatchUser> {
  late int counter;
  late TextEditingController controller;
  @override
  void initState() {
    counter = 0;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    counter = 0;
    final context = navigatorKey.currentContext;
    final matchUsersCubit = context?.watch<MatchUsersCubit>();
    matchUsersCubit?.restore();
    // game = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    final matchUsersCubit = context.watch<MatchUsersCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SimpleCustomInput(
          iconData: CupertinoIcons.person_2,
          controller: controller,
          placeholder:
              translate("CREATE_MATCH.SEARCH_USER"),
          onChanged: (value) async {
            counter++;
            Timer(
              const Duration(seconds: 1),
              () {
                counter--;
                setState(() {});
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        (counter == 0 && controller.text.isNotEmpty)
            ? FutureBuilder(
                future: _seatchUser(controller.text),
                builder:
                    (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final resp = snapshot.data;

                    if (resp!.isEmpty) return Container();

                    final users =
                        resp.map((e) => ChatUser.fromJson(e)).toList();
                    return Column(
                      children: [
                        const Text(
                          "Results: \n",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          color: Colors.black45,
                          child: ListView.builder(
                            itemCount: users.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                hoverColor: Colors.black,
                                shape: Border.all(color: Colors.blue, width: 1),
                                onTap: () {
                                  setState(() {
                                    controller.text = "";

                                    var foundedUser = matchUsersCubit.state.users.where(
                                        (user) => user.id == users[index].id);

                                    if (foundedUser.isEmpty) {
                                      matchUsersCubit.addUser(users[index]);
                                      // widget.users.add(users[index].id);
                                    }
                                  });
                                },
                                title: Wrap(
                                  spacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    CachedNetworkImage(imageUrl: users[index].thumb, width: 50, height: 50),
                                    Text(users[index].username)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            : Visibility(
              visible: matchUsersCubit.state.users.isNotEmpty,
              child: Column(
                  children: [
                    const Text(
                      "Inviteds:\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      color: Colors.black38,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: matchUsersCubit.state.users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            trailing: IconButton(
                              onPressed: () => setState(() {
                                matchUsersCubit.deleteUser(index);
                              }),
                              icon: const Icon(CupertinoIcons.xmark_circle),
                              color: Colors.redAccent,
                            ),
                            title: Wrap(
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border:
                                          Border.all(color: Colors.greenAccent)),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        matchUsersCubit.state.users[index].thumb,
                                        scale: 0.1),
                                    minRadius: 25,
                                    maxRadius: 35,
                                  ),
                                ),
                                Text(matchUsersCubit.state.users[index].name)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ),
      ],
    );
  }

  _seatchUser(String user) {
    return UserService().searchUser(user);
  }
}
