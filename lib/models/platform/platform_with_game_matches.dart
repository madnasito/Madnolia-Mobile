import 'dart:convert';

import 'package:madnolia/models/game/platform_game.dart';

PlatformWithGameMatches platformWithGameMatchesFromJson(String str) => PlatformWithGameMatches.fromJson(json.decode(str));

String platformWithGameMatchesToJson(PlatformWithGameMatches data) => json.encode(data.toJson());

class PlatformWithGameMatches {
    int platform;
    List<PlatformGame> games;

    PlatformWithGameMatches({
        required this.platform,
        required this.games,
    });

    factory PlatformWithGameMatches.fromJson(Map<String, dynamic> json) => PlatformWithGameMatches(
        platform: json["platform"],
        games: List<PlatformGame>.from(json["games"].map((x) => PlatformGame.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "games": List<dynamic>.from(games.map((x) => x.toJson())),
    };
}
