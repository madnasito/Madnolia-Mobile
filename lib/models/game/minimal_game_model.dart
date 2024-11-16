// To parse this JSON data, do
//
//     final minimalGame = minimalGameFromJson(jsonString);

import 'dart:convert';

MinimalGame minimalGameFromJson(String str) => MinimalGame.fromJson(json.decode(str));

String minimalGameToJson(MinimalGame data) => json.encode(data.toJson());

class MinimalGame {
    String id;
    String name;
    String? background;
    String slug;
    int gameId;

    MinimalGame({
        required this.id,
        required this.name,
        required this.background,
        required this.slug,
        required this.gameId,
    });

    factory MinimalGame.fromJson(Map<String, dynamic> json) => MinimalGame(
        id: json["_id"],
        name: json["name"],
        background: json["background"],
        slug: json["slug"],
        gameId: json["gameId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "background": background,
        "slug": slug,
        "gameId": gameId
    };
}
