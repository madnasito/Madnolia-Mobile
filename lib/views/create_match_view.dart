import 'dart:async';

import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/services/sockets_service.dart';
import 'package:Madnolia/widgets/language_builder.dart';
import 'package:Madnolia/widgets/search_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:Madnolia/utils/platform_id_ico.dart';
// import 'package:flutter/services.dart';

import 'package:Madnolia/widgets/form_button.dart';
import 'package:Madnolia/widgets/match_card_widget.dart';
import 'package:multi_language_json/multi_language_json.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../models/game_model.dart';
import '../services/rawg_service.dart';
import '../widgets/custom_input_widget.dart';

// ignore: must_be_immutable
class SearchGameView extends StatefulWidget {
  final int platformId;
  const SearchGameView({super.key, required this.platformId});

  @override
  State<SearchGameView> createState() => _SearchGameViewState();
}

class _SearchGameViewState extends State<SearchGameView> {
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
    // game = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LangSupport langData = LanguageBuilder.langData;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SimpleCustomInput(
          controller: controller,
          placeholder:
              langData.getValue(route: ["CREATE_MATCH", "SEARCH_GAME"]),
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
                future: getGames(
                    title: controller.text.toString(),
                    platform: "${widget.platformId}"),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: snapshot.data.isNotEmpty
                            ? ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => setState(() {
                                      context.go("/new/match", extra: {
                                        "game": snapshot.data[index],
                                        "platformId": widget.platformId
                                      });
                                    }),
                                    child: GameCard(
                                        game: snapshot.data[index],
                                        bottom: const Text("")),
                                  );
                                })
                            : Text(langData.getValue(
                                route: ["CREATE_MATCH", "EMPTY_SEARCH"])));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            : const Text(""),
      ],
    );
  }

  Future getGames({required String title, required String platform}) async {
    return RawgService().searchGame(game: title, platform: platform);
  }
}
final dateController = TextEditingController();
final nameController = TextEditingController();

class MatchFormView extends StatelessWidget {
  final Game game;
  final int platformId;

  const MatchFormView(
      {super.key, required this.game, required this.platformId});

  @override
  Widget build(BuildContext context) {
    LangSupport langData = LanguageBuilder.langData;
    ToastContext().init(context);
    bool uploading = false;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    
    final platformInfo = getPlatformInfo(platformId);
    List<String> users = [];
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(43, 0, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              color: Colors.white38,
              child: Stack(
                children: [
                  game.backgroundImage != null
                      ? Image.network(game.backgroundImage!)
                      : Image.asset("assets/no image.jpg"),
                  Positioned(
                    bottom: 2,
                    left: 2,
                    child: Text(
                      game.name,
                      style: const TextStyle(backgroundColor: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SimpleCustomInput(
                placeholder:
                    langData.getValue(route: ["CREATE_MATCH", "MATCH_NAME"]),
                controller: nameController),
            const SizedBox(height: 20),
            SimpleCustomInput(
              keyboardType: TextInputType.none,
              placeholder: langData.getValue(route: ["CREATE_MATCH", "DATE"]),
              controller: dateController,
              onTap: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  is24HourMode: false,
                  theme: ThemeData.dark(useMaterial3: true),
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  isForce2Digits: true,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                  selectableDayPredicate: (dateTime) {
                    // Disable 25th Feb 2023
                    if (dateTime == DateTime(2023, 2, 25)) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                );

                dateController.text = dateTime != null
                    ? dateTime.toString().substring(0, 16)
                    : "";
              },
            ),
            const SizedBox(height: 20),
            SeatchUser(users: users),
            const SizedBox(height: 20),
            Text(
              game.name,
              style: const TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                children: [
                  // Icon(Icons.gamepad_outlined),
                  SvgPicture.asset(
                    platformInfo.path,
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 110,
                  ),
                ]),
            const SizedBox(height: 20),
            Text(userProvider.user.name, style: TextStyle(fontSize: 10)),
            const SizedBox(height: 10),
            FormButton(
                text:
                    langData.getValue(route: ["CREATE_MATCH", "CREATE_MATCH"]),
                color: Colors.transparent,
                onPressed: () async {
                  if (uploading == true) {
                    
                    return Toast.show(
                        langData.getValue(
                            route: ["CREATE_MATCH", "UPLOADING_MESSAGE"]),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  }
                  if (dateController.text == "") {
                    return Toast.show(
                        langData
                            .getValue(route: ["CREATE_MATCH", "DATE_ERROR"]),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  }
                  int formDate =
                      DateTime.parse(dateController.text).millisecondsSinceEpoch;

                  Map match = {
                    "game_name": game.name,
                    "game_id": game.id.toString(),
                    "platform": platformId.toString(),
                    "date": formDate.toString(),
                    "name": nameController.text,
                    "img": game.backgroundImage,
                    "users": List<String>.from(users.map((x) => x))
                    // "tournament_match": "false"
                  };

                  uploading = true;
                  final resp = await MatchService().createMatch(match);
                  uploading = false;
                  if (resp["ok"] == true) {
                    Toast.show(
                        langData
                            .getValue(route: ["CREATE_MATCH", "MATCH_CREATED"]),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                    socketService.emit("match_created", resp["matchDB"]["_id"]);
                  } else {
                    Toast.show(
                        langData.getValue(route: ["CREATE_MATCH", "ERROR"]),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  }
                  // ignore: use_build_context_synchronously
                  dateController.clear();
                  nameController.clear();
                  context.goNamed("user-matches");
                })
          ],
        ),
      ),
    );
  }
}
