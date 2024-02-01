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
