// To parse this JSON data, do
//
//     final MatchWithGame = MatchWithGameFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/game/game_model.dart';

MatchWithGame matchWithGameFromJson(String str) => MatchWithGame.fromJson(json.decode(str));

String matchWithGameToJson(MatchWithGame data) => json.encode(data.toJson());

class MatchWithGame {
    String id;
    Game game;
    int platform;
    int date;
    String user;
    List<dynamic> inviteds;
    String title;
    List<dynamic> joined;
    bool private;
    bool tournament;
    int status;

    MatchWithGame({
        required this.id,
        required this.game,
        required this.platform,
        required this.date,
        required this.user,
        required this.inviteds,
        required this.title,
        required this.joined,
        required this.private,
        required this.status,
        required this.tournament,
    });

    factory MatchWithGame.fromJson(Map<String, dynamic> json) => MatchWithGame(
        id: json["_id"],
        game: Game.fromJson(json["game"]),
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
        inviteds: List<dynamic>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        joined: List<dynamic>.from(json["joined"].map((x) => x)),
        private: json["private"],
        status: json["status"],
        tournament: json["tournament"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "game": game.toJson(),
        "platform": platform,
        "date": date,
        "user": user,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "joined": List<dynamic>.from(joined.map((x) => x)),
        "private": private,
        "status": status,
        "tournament": tournament,
    };
}