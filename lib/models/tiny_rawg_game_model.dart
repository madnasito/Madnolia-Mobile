// To parse this JSON data, do
//
//     final tinyRawgGame = tinyRawgGameFromJson(jsonString);

import 'dart:convert';

TinyRawgGame tinyRawgGameFromJson(String str) => TinyRawgGame.fromJson(json.decode(str));

String tinyRawgGameToJson(TinyRawgGame data) => json.encode(data.toJson());

class TinyRawgGame {
    String name;
    int id;
    dynamic backgroundImage;

    TinyRawgGame({
        required this.name,
        required this.id,
        required this.backgroundImage,
    });

    factory TinyRawgGame.fromJson(Map<String, dynamic> json) => TinyRawgGame(
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
