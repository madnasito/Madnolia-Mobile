// To parse this JSON data, do
//
//     final homeGame = homeGameFromJson(jsonString);

import 'dart:convert';

HomeGame homeGameFromJson(String str) => HomeGame.fromJson(json.decode(str));

String homeGameToJson(HomeGame data) => json.encode(data.toJson());

class HomeGame {
    String id;
    int count;
    String name;
    String? background;
    String slug;

    HomeGame({
        required this.id,
        required this.count,
        required this.name,
        required this.background,
        required this.slug,
    });

    factory HomeGame.fromJson(Map<String, dynamic> json) => HomeGame(
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
