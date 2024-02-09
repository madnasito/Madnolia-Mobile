// To parse this JSON data, do
//
//     final match = matchFromJson(jsonString);

import 'dart:convert';

MinimalMatch matchFromJson(String str) =>
    MinimalMatch.fromJson(json.decode(str));

String matchToJson(MinimalMatch data) => json.encode(data.toJson());

class MinimalMatch {
  String id;
  String? img;
  String message;
  String gameName;
  int platform;
  int date;

  MinimalMatch(
      {this.id = "",
      required this.message,
      required this.gameName,
      required this.platform,
      required this.date,
      this.img});

  factory MinimalMatch.fromJson(Map<String, dynamic> json) => MinimalMatch(
        id: json["_id"],
        message: json["message"],
        gameName: json["game_name"],
        img: json["img"],
        platform: json["platform"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "game_name": gameName,
        "platform": platform,
        "img": img != null ? img : ""
      };
}
