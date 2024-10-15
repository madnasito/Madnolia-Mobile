import 'dart:async';

import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/models/match/create_match_model.dart';
import 'package:Madnolia/widgets/search_user_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:Madnolia/utils/platform_id_ico.dart';
// import 'package:flutter/services.dart';

import 'package:Madnolia/widgets/form_button.dart';
import 'package:Madnolia/widgets/match_card_widget.dart';
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
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SimpleCustomInput(
            controller: controller,
            placeholder:
                translate("CREATE_MATCH.SEARCH_GAME"),
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
                                    child:  GameCard(
                                        background: snapshot.data[index].backgroundImage,
                                        name: snapshot.data[index].name,
                                        bottom: const Text("")),
                                  );
                                })
                            : Text(translate("CREATE_MATCH.EMPTY_SEARCH")));
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
    ToastContext().init(context);
    bool uploading = false;
    final userState = context.read<UserBloc>().state;
    
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
                      ? CachedNetworkImage(imageUrl: game.backgroundImage!)
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
                    translate("CREATE_MATCH.MATCH_NAME"),
                controller: nameController),
            const SizedBox(height: 20),
            SimpleCustomInput(
              keyboardType: TextInputType.none,
              placeholder: translate("CREATE_MATCH.DATE"),
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
            Text(userState.name, style: const TextStyle(fontSize: 10)),
            const SizedBox(height: 10),
            FormButton(
                text:
                    translate("CREATE_MATCH.CREATE_MATCH"),
                color: Colors.transparent,
                onPressed: () async {
                  
                  if (uploading == true) {
                    
                    return Toast.show(
                        translate("CREATE_MATCH.UPLOADING_MESSAGE"),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  }
                  if (dateController.text == "") {
                    return Toast.show(
                        translate("CREATE_MATCH.DATE_ERROR"),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  }
                  // if (nameController.text == "") {
                  //   return Toast.show(
                  //       translate("CREATE_MATCH.TITLE_EMPTY"),
                  //       gravity: 100,
                  //       border: Border.all(color: Colors.blueAccent),
                  //       textStyle: const TextStyle(fontSize: 18),
                  //       duration: 3);
                  // }
                  int formDate =
                      DateTime.parse(dateController.text).millisecondsSinceEpoch;

                  // Map match = {
                    // "game_name": game.name,
                    // "game": game.id.toString(),
                    // "platform": platformId.toString(),
                    // "date": formDate.toString(),
                    // "name": nameController.text,
                    // "img": game.backgroundImage,
                    // "users": List<String>.from(users.map((x) => x))
                    // "tournament_match": "false"
                  // };

                  CreateMatch match = CreateMatch(
                    title: nameController.text,
                    date: formDate,
                    inviteds: users,
                    game: game.id,
                    platform: platformId,
                    );

                  uploading = true;
                  final Map<String, dynamic> resp = await MatchService().createMatch(match.toJson());
                  uploading = false;
                  if (resp.containsKey("message")) {
                    Toast.show(
                        translate("CREATE_MATCH.ERROR"),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                  } else {
                    Toast.show(
                        translate("CREATE_MATCH.MATCH_CREATED"),
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3);
                      // MatchCreated matchCreated = MatchCreated.fromJson(resp);
                    dateController.clear();
                    nameController.clear();
                    context.goNamed("user-matches");
                  }
                  // ignore: use_build_context_synchronously
                })
          ],
        ),
      ),
    );
  }
}
