// To parse this JSON data, do
//
//     final platformGamesModel = platformGamesModelFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/game/home_game_model.dart';

enum PlatformGamesStatus { initial, loading, success, failure }

PlatformGamesModel platformGamesModelFromJson(String str) => PlatformGamesModel.fromJson(json.decode(str));

String platformGamesModelToJson(PlatformGamesModel data) => json.encode(data.toJson());

class PlatformGamesModel {
    int platform;
    List<HomeGame> games;
    int page = 0;
    PlatformGamesStatus status;
    bool hasReachedMax;

    PlatformGamesModel({
        required this.platform,
        required this.games,
        required this.page,
        required this.status,
        required this.hasReachedMax,
    });

    factory PlatformGamesModel.fromJson(Map<String, dynamic> json) => PlatformGamesModel(
        platform: json["platform"],
        games: List<HomeGame>.from(json["games"].map((x) => x)),
        page: json["page"],
        status: json["status"],
        hasReachedMax: json["hasReachedMax"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "games": List<HomeGame>.from(games.map((x) => x)),
        "page": page,
        "status": status,
        "hasReachedMax": hasReachedMax,
    };
}
