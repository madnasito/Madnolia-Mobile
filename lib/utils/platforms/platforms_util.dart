import 'package:flutter/material.dart' show Color, Colors;
import 'package:madnolia/models/platform/platform_icon_model.dart';

List<PlatformIconModel> getFatherPlatforms() {
  return [
    PlatformIconModel(
        id: 1,
        path: "assets/platforms/nintendo.svg",
        active: false,
        size: 25,
        background: const Color(0xffed1c24)),
    PlatformIconModel(
        id: 2,
        path: "assets/platforms/playstation.svg",
        active: false,
        size: 25,
        background: Colors.blue),
    PlatformIconModel(
        id: 3,
        path: "assets/platforms/xbox.svg",
        active: false,
        size: 25,
        background: Colors.green),
  ];
}

List<PlatformIconModel> getPlaystationChildren(List<int> selectedPlatforms){
  return [
      PlatformIconModel(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: selectedPlatforms.contains(17) ? true : false,
          size: 20),
      PlatformIconModel(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: selectedPlatforms.contains(15) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: selectedPlatforms.contains(16) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: selectedPlatforms.contains(18) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: selectedPlatforms.contains(187) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: selectedPlatforms.contains(19) ? true : false,
          size: 20, padding: 20),
    ];
}

List<PlatformIconModel> getNintendoChildren(List<int> selectedPlatforms) {
  return [
      PlatformIconModel(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: selectedPlatforms.contains(17) ? true : false,
          size: 20),
      PlatformIconModel(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: selectedPlatforms.contains(15) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: selectedPlatforms.contains(16) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: selectedPlatforms.contains(18) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: selectedPlatforms.contains(187) ? true : false,
          size: 20, padding: 20),
      PlatformIconModel(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: selectedPlatforms.contains(19) ? true : false,
          size: 20, padding: 20),
    ];
}

List<PlatformIconModel> getXboxChildren(List<int> selectedPlatforms) {
  return  [
      PlatformIconModel(
          id: 14,
          active: selectedPlatforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_360.svg",
          size: 20, padding: 15),
      PlatformIconModel(
          id: 1,
          active: selectedPlatforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 20, padding: 15),
      PlatformIconModel(
          id: 186,
          active: selectedPlatforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 20, padding: 15)
    ];
}

List<PlatformIconModel> getOthersPlatforms(List<int> selectedPlatforms) {
  return [
      PlatformIconModel(
          id: 4,
          path: "assets/platforms/pc.svg",
          active: selectedPlatforms.contains(4) ? true : false,
          size: 25),
      PlatformIconModel(
          id: 21,
          path: "assets/platforms/smartphone.svg",
          active: selectedPlatforms.contains(21) ? true : false,
          size: 25),
    ];
}