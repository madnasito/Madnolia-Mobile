import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import 'package:animate_do/animate_do.dart';


import 'package:madnolia/views/create_match_view.dart';

import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import '../../widgets/platform_icon_widget.dart';

// ignore: must_be_immutable
class NewPage extends StatefulWidget {
  NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
  int selectedPlatform = 0;
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {

    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is int) {
        widget.selectedPlatform = GoRouterState.of(context).extra as int;
      }
    }

    return CustomScaffold(
        body: Background(
            child: widget.selectedPlatform == 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        FadeIn(
                            delay: const Duration(milliseconds: 300),
                            child: Text(
                              translate("CREATE_MATCH.TITLE"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            )),
                        const SizedBox(height: 40),
                        SingleChildScrollView(
                          dragStartBehavior: DragStartBehavior.start,
                          child: FadeIn(
                            delay: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                const SizedBox(height: 70),
                                ..._toMap(),
                                const SizedBox(height: 70),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SearchGameView(platformId: widget.selectedPlatform)));
  }

  List<Widget> _toMap() {
    final userBloc = context.watch<UserBloc>();
    List<Platform> platforms = [
      Platform(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: userBloc.state.platforms.contains(17) ? true : false,
          size: 20, padding: 10),
      Platform(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: userBloc.state.platforms.contains(15) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: userBloc.state.platforms.contains(16) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: userBloc.state.platforms.contains(18) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: userBloc.state.platforms.contains(187) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: userBloc.state.platforms.contains(19) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 9,
          active: userBloc.state.platforms.contains(9) ? true : false,
          path: "assets/platforms/nintendo_ds.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 8,
          active: userBloc.state.platforms.contains(8) ? true : false,
          path: "assets/platforms/nintendo_3ds.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 11,
          active: userBloc.state.platforms.contains(11) ? true : false,
          path: "assets/platforms/nintendo_wii.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 10,
          active: userBloc.state.platforms.contains(10) ? true : false,
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 7,
          active: userBloc.state.platforms.contains(7) ? true : false,
          path: "assets/platforms/nintendo_switch.svg",
          size: 20, padding: 20),
      Platform(
          id: 14,
          active: userBloc.state.platforms.contains(14) ? true : false,
          path: "assets/platforms/xbox_360.svg",
          size: 20, padding: 20),
      Platform(
          id: 1,
          active: userBloc.state.platforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 20, padding: 20),
      Platform(
          id: 186,
          active: userBloc.state.platforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 20, padding: 20),
      Platform(
          id: 4,
          active: userBloc.state.platforms.contains(4) ? true : false,
          path: "assets/platforms/pc.svg",
          size: 30, padding: 20),
      Platform(
          id: 21,
          active: userBloc.state.platforms.contains(21) ? true : false,
          path: "assets/platforms/smartphone.svg",
          size: 30, padding: 20)
    ];
    return platforms
        .map((item) => FadeIn(
            child: item.active
                ? GestureDetector(
                    onTap: () {
                      widget.selectedPlatform = item.id;
                      setState(() {});
                    },
                    child: PlatformIcon(platform: item))
                : Container()))
        .toList();
  }
}
