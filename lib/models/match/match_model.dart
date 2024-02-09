// To parse this JSON data, do
//
//     final match = matchFromJson(jsonString);

import 'dart:convert';

import 'package:Madnolia/models/chat_user_model.dart';

Match matchFromJson(String str) => Match.fromJson(json.decode(str));

String matchToJson(Match data) => json.encode(data.toJson());

class Match {
  String id;
  List<String> users;
  String? img;
  String message;
  List<ChatUser> likes;
  bool active;
  bool tournamentMatch;
  String gameName;
  String gameId;
  int platform;
  int date;
  String user;

  Match(
      {this.id = "",
      required this.users,
      required this.message,
      required this.likes,
      this.active = true,
      this.tournamentMatch = false,
      required this.gameName,
      required this.gameId,
      required this.platform,
      required this.date,
      this.user = "",
      this.img});

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["_id"],
        users: List<String>.from(json["users"].map((x) => x)),
        message: json["message"],
        likes:
            List<ChatUser>.from(json["likes"].map((x) => ChatUser.fromJson(x))),
        active: json["active"],
        tournamentMatch: json["tournament_match"],
        gameName: json["game_name"],
        gameId: json["game_id"],
        img: json["img"],
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "users": List<String>.from(users.map((x) => x)),
        "message": message,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "active": active,
        "tournament_match": tournamentMatch,
        "game_name": gameName,
        "game_id": gameId,
        "platform": platform,
        "date": date,
        "user": user,
        "img": img != null ? img : ""
      };
}
