// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
    String id;
    String name;
    String slug;
    int gameId;
    List<Platform> platforms;
    String? background;
    List<dynamic> screenshots;
    String description;

    Game({
        required this.id,
        required this.name,
        required this.slug,
        required this.gameId,
        required this.platforms,
        required this.background,
        required this.screenshots,
        required this.description,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        gameId: json["gameId"],
        platforms: List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
        background: json["background"],
        screenshots: List<dynamic>.from(json["screenshots"].map((x) => x)),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "gameId": gameId,
        "platforms": List<dynamic>.from(platforms.map((x) => x.toJson())),
        "background": background,
        "screenshots": List<dynamic>.from(screenshots.map((x) => x)),
        "description": description,
    };
}

class Platform {
    int id;
    int amount;

    Platform({
        required this.id,
        required this.amount,
    });

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json["id"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
    };
}
