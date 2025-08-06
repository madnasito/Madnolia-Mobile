// To parse this JSON data, do
//
//     final platformGamesModel = platformGamesModelFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/game/platform_game.dart';

enum PlatformGamesStatus { initial, loading, success, failure }

PlatformGamesModel platformGamesModelFromJson(String str) => PlatformGamesModel.fromJson(json.decode(str));

String platformGamesModelToJson(PlatformGamesModel data) => json.encode(data.toJson());

class PlatformGamesModel {
    int platform;
    List<PlatformGame> games;
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
        games: List<PlatformGame>.from(json["games"].map((x) => x)),
        page: json["page"],
        status: json["status"],
        hasReachedMax: json["hasReachedMax"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "games": List<PlatformGame>.from(games.map((x) => x)),
        "page": page,
        "status": status,
        "hasReachedMax": hasReachedMax,
    };
}
