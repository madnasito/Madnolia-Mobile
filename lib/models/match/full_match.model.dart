// To parse this JSON data, do
//
//     final fullMatch = fullMatchFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/game/minimal_game_model.dart';

FullMatch fullMatchFromJson(String str) => FullMatch.fromJson(json.decode(str));

String fullMatchToJson(FullMatch data) => json.encode(data.toJson());

class FullMatch {
    String id;
    MinimalGame game;
    int platform;
    int date;
    ChatUser user;
    List<String> inviteds;
    String title;
    List<ChatUser> joined;
    bool private;
    bool tournament;
    int status;

    FullMatch({
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

    factory FullMatch.fromJson(Map<String, dynamic> json) => FullMatch(
        id: json["_id"],
        game: MinimalGame.fromJson(json["game"]),
        platform: json["platform"],
        date: json["date"],
        user: ChatUser.fromJson(json["user"]),
        inviteds: List<String>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        joined: List<ChatUser>.from(json["joined"].map((x) => ChatUser.fromJson(x))),
        private: json["private"],
        status: json["status"],
        tournament: json["tournament"]
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "game": game.toJson(),
        "platform": platform,
        "date": date,
        "user": user.toJson(),
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "joined": List<dynamic>.from(joined.map((x) => x.toJson())),
        "private": private,
        "status": status,
        "tournament": tournament,
    };
}
