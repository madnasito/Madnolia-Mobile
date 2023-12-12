import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:madnolia/widgets/form_button.dart';
import 'package:madnolia/widgets/match_card_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../models/game_model.dart';
import '../services/rawg_service.dart';
import '../widgets/custom_input_widget.dart';

Game? game;

class CreateMatchView extends StatefulWidget {
  const CreateMatchView({super.key});

  @override
  State<CreateMatchView> createState() => _CreateMatchViewState();
}

class _CreateMatchViewState extends State<CreateMatchView> {
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return game == null
        ? const SearchGameView()
        : Container(
            height: double.infinity,
            color: const Color.fromARGB(43, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SearchGameView(),
                  Stack(
                    children: [
                      Image.network(game!.backgroundImage.toString(),
                          semanticLabel: "Este es un label"),
                      Positioned(
                        bottom: 2,
                        left: 2,
                        child: Text(
                          game!.name,
                          style:
                              const TextStyle(backgroundColor: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SimpleCustomInput(
                      placeholder: "Match Name",
                      controller: TextEditingController()),
                  SimpleCustomInput(
                    placeholder: "Date",
                    controller: dateController,
                    onTap: () async {
                      DateTime? dateTime = await showOmniDateTimePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        lastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: false,
                        isShowSeconds: false,
                        minutesInterval: 1,
                        secondsInterval: 1,
                        isForce2Digits: true,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
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
                  Text(
                    game!.name,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Wrap(children: [
                    Icon(Icons.gamepad_outlined),
                    Text("  PlayStation 3",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ]),
                  const SizedBox(height: 20),
                  const Text("MADNA", style: TextStyle(fontSize: 10)),
                  const SizedBox(height: 10),
                  FormButton(
                      text: "Create Match",
                      color: Colors.transparent,
                      onPressed: () {})
                ],
              ),
            ),
          );
  }
}

// ignore: must_be_immutable
class SearchGameView extends StatefulWidget {
  const SearchGameView({
    super.key,
  });

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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SimpleCustomInput(
          controller: controller,
          placeholder: "Search Game",
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
        (counter == 0 && controller.text.isNotEmpty)
            ? FutureBuilder(
                future:
                    getGames(title: controller.text.toString(), platform: "15"),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => setState(() {
                                  game = snapshot.data[index];
                                }),
                                child: GameCard(
                                    game: snapshot.data[index],
                                    bottom: const Text("")),
                              );
                            }));
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
