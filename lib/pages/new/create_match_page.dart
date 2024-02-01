import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:multi_language_json/multi_language_json.dart';

import 'package:Madnolia/providers/user_provider.dart';

import 'package:Madnolia/views/create_match_view.dart';

import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:Madnolia/widgets/language_builder.dart';

import '../../widgets/platform_icon_widget.dart';

class NewPage extends StatefulWidget {
  NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
  int selectedPlatform = 0;
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    final LangSupport langData = LanguageBuilder.langData;

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
                              langData
                                  .getValue(route: ["CREATE_MATCH", "TITLE"]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<Platform> platforms = [
      Platform(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: userProvider.user.platforms.contains(17) ? true : false,
          size: 20),
      Platform(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: userProvider.user.platforms.contains(15) ? true : false,
          size: 60),
      Platform(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: userProvider.user.platforms.contains(16) ? true : false,
          size: 60),
      Platform(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: userProvider.user.platforms.contains(18) ? true : false,
          size: 60),
      Platform(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: userProvider.user.platforms.contains(187) ? true : false,
          size: 60),
      Platform(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: userProvider.user.platforms.contains(19) ? true : false,
          size: 20),
      Platform(
          id: 9,
          active: userProvider.user.platforms.contains(9) ? true : false,
          path: "assets/platforms/nintendo_ds.svg",
          size: 13,
          padding: 10),
      Platform(
          id: 8,
          active: userProvider.user.platforms.contains(8) ? true : false,
          path: "assets/platforms/nintendo_3ds.svg",
          size: 10,
          padding: 10),
      Platform(
          id: 11,
          active: userProvider.user.platforms.contains(11) ? true : false,
          path: "assets/platforms/nintendo_wii.svg",
          size: 20,
          padding: 12),
      Platform(
          id: 10,
          active: userProvider.user.platforms.contains(10) ? true : false,
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20,
          padding: 12),
      Platform(
          id: 7,
          active: userProvider.user.platforms.contains(7) ? true : false,
          path: "assets/platforms/nintendo_switch.svg",
          size: 70),
      Platform(
          id: 14,
          active: userProvider.user.platforms.contains(14) ? true : false,
          path: "assets/platforms/xbox_360.svg",
          size: 70),
      Platform(
          id: 1,
          active: userProvider.user.platforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 70),
      Platform(
          id: 186,
          active: userProvider.user.platforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 30),
      Platform(
          id: 4,
          active: userProvider.user.platforms.contains(4) ? true : false,
          path: "assets/platforms/pc.svg",
          size: 40),
      Platform(
          id: 21,
          active: userProvider.user.platforms.contains(21) ? true : false,
          path: "assets/platforms/smartphone.svg",
          size: 40)
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
