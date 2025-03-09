import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/widgets/platform_icon_widget.dart';

import '../blocs/user/user_bloc.dart';

PlatformInfo getPlatformInfo(int id) {
  const String path = "assets/platforms";
  switch (id) {
    // Playstation's platforms
    case 15:
      return PlatformInfo(
          path: "$path/playstation_2.svg", name: "PlayStation 2");
    case 16:
      return PlatformInfo(
          path: "$path/playstation_3.svg", name: "PlayStation 3");
    case 17:
      return PlatformInfo(
          path: "$path/playstation_portable.svg", name: "PlayStation Portable");
    case 18:
      return PlatformInfo(
          path: "$path/playstation_4.svg", name: "PlayStation 4");
    case 19:
      return PlatformInfo(
          path: "$path/playstation_vita.svg", name: "PlayStation Vita");
    case 187:
      return PlatformInfo(
          path: "$path/playstation_5.svg", name: "PlayStation 5");

    // Nintendo's Platforms
    case 9:
      return PlatformInfo(path: "$path/nintendo_ds.svg", name: "Nintendo DS");
    case 7:
      return PlatformInfo(
          path: "$path/nintendo_switch.svg", name: "Nintendo Switch");
    case 8:
      return PlatformInfo(path: "$path/nintendo_3ds.svg", name: "Nintendo 3DS");

    case 10:
      return PlatformInfo(
          path: "$path/nintendo_wiiu.svg", name: "Nintendo WiiU");
    case 11:
      return PlatformInfo(path: "$path/nintendo_wii.svg", name: "Nintendo Wii");

    case 80:
      return PlatformInfo(path: "$path/xbox.svg", name: "Xbox Classic");
    case 14:
      return PlatformInfo(path: "$path/xbox_360.svg", name: "Xbox 360");
    case 1:
      return PlatformInfo(path: "$path/xbox_one.svg", name: "Xbox One");
    case 186:
      return PlatformInfo(path: "$path/xbox_series.svg", name: "Xbox Series");

    case 4:
      return PlatformInfo(path: "$path/pc.svg", name: "PC");
    case 21:
      return PlatformInfo(path: "$path/smartphone.svg", name: "Mobile");

    default:
      return PlatformInfo(path: "$path/mobile.svg", name: "PlayStation 4");
  }
}

class PlatformInfo {
  String path;
  String name;
  PlatformInfo({required this.path, required this.name});
}


List<Widget> usserPlatforms(BuildContext context, void Function()? onTap) {
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
                    onTap: onTap,
                    child: PlatformIcon(platform: item))
                : Container()))
        .toList();
  }