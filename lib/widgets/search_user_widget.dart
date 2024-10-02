import 'dart:async';

import 'package:Madnolia/models/chat_user_model.dart';
import 'package:Madnolia/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'custom_input_widget.dart';

class SeatchUser extends StatefulWidget {
  final List<String> users;
  const SeatchUser({super.key, required this.users});

  @override
  State<SeatchUser> createState() => _SeatchUserState();
}

class _SeatchUserState extends State<SeatchUser> {
  late int counter;
  late TextEditingController controller;
  late List usersList;
  @override
  void initState() {
    counter = 0;
    controller = TextEditingController();
    usersList = [];
    super.initState();
  }

  @override
  void dispose() {
    counter = 0;
    // game = null;
    usersList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SimpleCustomInput(
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
                                  controller.text = "";

                                  var foundedUser = usersList.where(
                                      (user) => user["id"] == users[index].id);

                                  if (foundedUser.isEmpty) {
                                    usersList.add({
                                      "id": users[index].id,
                                      "name": users[index].name,
                                      "img": users[index].thumb
                                    });
                                    widget.users.add(users[index].id);
                                  }
                                  setState(() {});
                                },
                                title: Wrap(
                                  spacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Image.network(
                                      users[index].thumb,
                                      width: 50,
                                      height: 50,
                                    ),
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
              visible: usersList.isNotEmpty,
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
                        itemCount: usersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
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
                                        usersList[index]["img"],
                                        scale: 0.1),
                                    minRadius: 25,
                                    maxRadius: 35,
                                  ),
                                ),
                                Text(usersList[index]["name"])
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
