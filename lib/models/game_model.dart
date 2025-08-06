// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
    String name;
    int id;
    String? backgroundImage;

    Game({
        required this.name,
        required this.id,
        required this.backgroundImage,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        name: json["name"],
        id: json["id"],
        backgroundImage: json["background_image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "background_image": backgroundImage,
    };
}
