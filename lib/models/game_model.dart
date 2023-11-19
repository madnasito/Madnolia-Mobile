import 'dart:convert';

Game gameFromJson(String str) => Game.fromJson(jsonDecode(str));

class Game {
  String name;
  int id;
  String backgroundImage;
  // List<Platform> platforms;

  Game({
    required this.name,
    required this.backgroundImage,
    required this.id,
    //  required this.platforms
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
      name: json["name"],
      id: json["id"],
      backgroundImage: json["background_image"]);
}



// class Platform {
//   Genre platform;

//   Platform({
//     required this.platform,
//   });

//   factory Platform.fromJson(Map<String, dynamic> json) => Platform(
//         platform: Genre.fromJson(json["platform"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "platform": platform.toJson(),
//       };
// }
