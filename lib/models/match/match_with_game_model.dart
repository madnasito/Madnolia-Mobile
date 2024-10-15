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
    List<dynamic> likes;
    bool private;
    bool active;
    bool tournament;

    MatchWithGame({
        required this.id,
        required this.game,
        required this.platform,
        required this.date,
        required this.user,
        required this.inviteds,
        required this.title,
        required this.likes,
        required this.private,
        required this.active,
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
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        private: json["private"],
        active: json["active"],
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
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "private": private,
        "active": active,
        "tournament": tournament,
    };
}