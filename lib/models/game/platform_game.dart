// To parse this JSON data, do
//
//     final homeGame = homeGameFromJson(jsonString);

import 'dart:convert';

PlatformGame homeGameFromJson(String str) => PlatformGame.fromJson(json.decode(str));

String homeGameToJson(PlatformGame data) => json.encode(data.toJson());

class PlatformGame {
    String id;
    int count;
    String name;
    String? background;
    String slug;

    PlatformGame({
        required this.id,
        required this.count,
        required this.name,
        required this.background,
        required this.slug,
    });

    factory PlatformGame.fromJson(Map<String, dynamic> json) => PlatformGame(
        id: json["_id"],
        count: json["count"],
        name: json["name"],
        background: json["background"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
        "name": name,
        "background": background,
        "slug": slug,
    };
}
