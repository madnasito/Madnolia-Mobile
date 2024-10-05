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
    String? background;
    List<String> screenshots;
    String description;

    Game({
        required this.id,
        required this.name,
        required this.slug,
        required this.gameId,
        required this.background,
        required this.screenshots,
        required this.description,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        gameId: json["gameId"],
        background: json["background"],
        screenshots: List<String>.from(json["screenshots"].map((x) => x)),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "gameId": gameId,
        "background": background,
        "screenshots": List<String>.from(screenshots.map((x) => x)),
        "description": description,
    };
}
