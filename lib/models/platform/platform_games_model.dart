// To parse this JSON data, do
//
//     final platformGamesModel = platformGamesModelFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/game/home_game_model.dart';

PlatformGamesModel platformGamesModelFromJson(String str) => PlatformGamesModel.fromJson(json.decode(str));

String platformGamesModelToJson(PlatformGamesModel data) => json.encode(data.toJson());

class PlatformGamesModel {
    int platform;
    List<HomeGame> games;

    PlatformGamesModel({
        required this.platform,
        required this.games,
    });

    factory PlatformGamesModel.fromJson(Map<String, dynamic> json) => PlatformGamesModel(
        platform: json["platform"],
        games: List<HomeGame>.from(json["games"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "games": List<HomeGame>.from(games.map((x) => x)),
    };
}
