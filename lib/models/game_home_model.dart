// To parse this JSON data, do
//
//     final gamesHomeResponse = gamesHomeResponseFromJson(jsonString);

import 'dart:convert';

GamesHomeResponse gamesHomeResponseFromJson(String str) =>
    GamesHomeResponse.fromJson(json.decode(str));

String gamesHomeResponseToJson(GamesHomeResponse data) =>
    json.encode(data.toJson());

class GamesHomeResponse {
  String name;
  String platformCategory;
  int platform;
  List<Game> games;

  GamesHomeResponse({
    required this.name,
    required this.platformCategory,
    required this.platform,
    required this.games,
  });

  factory GamesHomeResponse.fromJson(Map<String, dynamic> json) =>
      GamesHomeResponse(
        platformCategory: json["platform_category"],
        name: json["name"],
        platform: json["platform"],
        games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "platform_category": platformCategory,
        "name": name,
        "platform": platform,
        "games": List<dynamic>.from(games.map((x) => x.toJson())),
      };
}

class Game {
  List<dynamic> screenshots;
  String id;
  String name;
  int gameId;
  List<Platform> platforms;
  String backgroundImage;
  int v;

  Game({
    required this.screenshots,
    required this.id,
    required this.name,
    required this.gameId,
    required this.platforms,
    required this.backgroundImage,
    required this.v,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        screenshots: List<dynamic>.from(json["screenshots"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        gameId: json["game_id"],
        platforms: List<Platform>.from(
            json["platforms"].map((x) => Platform.fromJson(x))),
        backgroundImage: json["background_image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "screenshots": List<dynamic>.from(screenshots.map((x) => x)),
        "_id": id,
        "name": name,
        "game_id": gameId,
        "platforms": List<dynamic>.from(platforms.map((x) => x.toJson())),
        "background_image": backgroundImage,
        "__v": v,
      };
}

class Platform {
  int platformId;
  int amount;

  Platform({
    required this.platformId,
    required this.amount,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        platformId: json["platform_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "platform_id": platformId,
        "amount": amount,
      };
}
