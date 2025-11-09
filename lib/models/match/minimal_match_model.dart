// To parse this JSON data, do
//
//     final match = matchFromJson(jsonString);

import 'dart:convert';

MinimalMatch matchFromJson(String str) =>
    MinimalMatch.fromJson(json.decode(str));

String matchToJson(MinimalMatch data) => json.encode(data.toJson());

class MinimalMatch {
  String id;
  String title;
  int platform;
  DateTime date;

  MinimalMatch(
      {this.id = "",
      required this.title,
      required this.platform,
      required this.date,
  });

  factory MinimalMatch.fromJson(Map<String, dynamic> json) => MinimalMatch(
        id: json["_id"],
        title: json["title"],
        platform: json["platform"],
        date: DateTime.parse(json["date"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "platform": platform
      };
}
