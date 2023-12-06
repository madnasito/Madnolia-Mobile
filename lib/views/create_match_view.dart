import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:madnolia/widgets/form_button.dart';
import 'package:madnolia/widgets/match_card_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../models/game_model.dart';
import '../services/rawg_service.dart';
import '../widgets/custom_input_widget.dart';

class CreateMatchView extends StatelessWidget {
  const CreateMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(43, 0, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                Image.asset("assets/game_example_5.jpg",
                    semanticLabel: "Este es un label"),
                const Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    "FINAL FANTASY XIII-2",
                    style: TextStyle(backgroundColor: Colors.black54),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // CustomInput(
            //     icon: Icons.mic_none,
            //     placeholder: "Match Name",
            //     textController: TextEditingController()),
            // CustomInput(
            //   keyboardType: TextInputType.none,
            //   icon: Icons.date_range,
            //   placeholder: "Date",
            //   textController: dateController,
            //   onTap: () async {
            //     DateTime? dateTime = await showOmniDateTimePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate:
            //           DateTime(1600).subtract(const Duration(days: 3652)),
            //       lastDate: DateTime.now().add(
            //         const Duration(days: 3652),
            //       ),
            //       is24HourMode: false,
            //       isShowSeconds: false,
            //       minutesInterval: 1,
            //       secondsInterval: 1,
            //       isForce2Digits: true,
            //       borderRadius: const BorderRadius.all(Radius.circular(16)),
            //       constraints: const BoxConstraints(
            //         maxWidth: 350,
            //         maxHeight: 650,
            //       ),
            //       transitionBuilder: (context, anim1, anim2, child) {
            //         return FadeTransition(
            //           opacity: anim1.drive(
            //             Tween(
            //               begin: 0,
            //               end: 1,
            //             ),
            //           ),
            //           child: child,
            //         );
            //       },
            //       transitionDuration: const Duration(milliseconds: 200),
            //       barrierDismissible: true,
            //       selectableDayPredicate: (dateTime) {
            //         // Disable 25th Feb 2023
            //         if (dateTime == DateTime(2023, 2, 25)) {
            //           return false;
            //         } else {
            //           return true;
            //         }
            //       },
            //     );

            //     dateController.text = dateTime != null
            //         ? dateTime.toString().substring(0, 16)
            //         : "";
            //   },
            // ),
            const Text(
              "FINAL FANTASY XIII-2",
              style: TextStyle(
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
  final TextEditingController controller;

  SearchGameView({
    super.key,
    required this.controller,
  });

  int counter = 0;
  late final Game game;
  @override
  State<SearchGameView> createState() => _SearchGameViewState();
}

class _SearchGameViewState extends State<SearchGameView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CustomInput(
        //   icon: Icons.gamepad,
        //   placeholder: "Search Game",
        //   onChanged: (value) async {
        //     widget.counter++;
        //     Timer(
        //       const Duration(seconds: 1),
        //       () {
        //         widget.counter--;
        //         setState(() {});
        //       },
        //     );
        //   },
        // ),
        (widget.counter == 0 && widget.controller.text.isNotEmpty)
            ? FutureBuilder(
                future: getGames(title: widget.controller.text, platform: "15"),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => widget.game = snapshot.data[index],
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
