// To parse this JSON data, do
//
//     final match = matchFromJson(jsonString);

import 'dart:convert';

Match matchFromJson(String str) => Match.fromJson(json.decode(str));

String matchToJson(Match data) => json.encode(data.toJson());

class Match {
  String id;
  List<dynamic> users;
  String? img;
  String message;
  List<String> likes;
  bool active;
  bool tournamentMatch;
  String gameName;
  String gameId;
  int platform;
  int date;
  String user;
  List<dynamic> chat;

  Match(
      {required this.id,
      required this.users,
      required this.message,
      required this.likes,
      required this.active,
      required this.tournamentMatch,
      required this.gameName,
      required this.gameId,
      required this.platform,
      required this.date,
      required this.user,
      required this.chat,
      this.img});

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["_id"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
        message: json["message"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        active: json["active"],
        tournamentMatch: json["tournament_match"],
        gameName: json["game_name"],
        gameId: json["game_id"],
        img: json["img"],
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
        chat: List<dynamic>.from(json["chat"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "users": List<dynamic>.from(users.map((x) => x)),
        "message": message,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "active": active,
        "tournament_match": tournamentMatch,
        "game_name": gameName,
        "game_id": gameId,
        "platform": platform,
        "date": date,
        "user": user,
        "chat": List<dynamic>.from(chat.map((x) => x)),
      };
}
