// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:madnolia/database/database.dart';

import '../../enums/platforms_id.enum.dart';

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
    List<PlatformId> platforms;

    Game({
        required this.id,
        required this.name,
        required this.slug,
        required this.gameId,
        required this.background,
        required this.screenshots,
        required this.description,
        required this.platforms
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        gameId: json["gameId"],
        background: json["background"],
        screenshots: List<String>.from(json["screenshots"].map((x) => x)),
        description: json["description"],
        platforms: List<PlatformId>.from(json["platforms"].map((x) => PlatformId.values.firstWhere((e) => e.id == x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "gameId": gameId,
        "background": background,
        "screenshots": List<String>.from(screenshots.map((x) => x)),
        "description": description,
        "platforms": List<dynamic>.from(platforms.map((x) => x.id)),
    };

    GameCompanion toCompanion() {
      return GameCompanion(
        id: Value(id),
        name: Value(name),
        platforms: Value(platforms),
        screenshots: Value(screenshots),
        slug: Value(slug),
        apiId: Value(gameId),
        background: Value(background),
        description: Value(description),
        lastUpdated: Value(DateTime.now()),
      );
    }
}
