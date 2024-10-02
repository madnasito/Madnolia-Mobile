// To parse this JSON data, do
//
//     final fullMatch = fullMatchFromJson(jsonString);

import 'dart:convert';

import 'package:Madnolia/models/chat_user_model.dart';
import 'package:Madnolia/models/game/minimal_game_model.dart';

FullMatch fullMatchFromJson(String str) => FullMatch.fromJson(json.decode(str));

String fullMatchToJson(FullMatch data) => json.encode(data.toJson());

class FullMatch {
    String id;
    MinimalGame game;
    int platform;
    int date;
    String user;
    List<String> inviteds;
    String title;
    List<ChatUser> likes;
    bool private;
    bool active;
    bool tournament;

    FullMatch({
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

    factory FullMatch.fromJson(Map<String, dynamic> json) => FullMatch(
        id: json["_id"],
        game: MinimalGame.fromJson(json["game"]),
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
        inviteds: List<String>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        likes: List<ChatUser>.from(json["likes"].map((x) => ChatUser.fromJson(x))),
        private: json["private"],
        active: json["active"],
        tournament: json["tournament"]
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "game": game.toJson(),
        "platform": platform,
        "date": date,
        "user": user,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "private": private,
        "active": active,
        "tournament": tournament,
    };
}
