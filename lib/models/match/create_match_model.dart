// To parse this JSON data, do
//
//     final createMatch = createMatchFromJson(jsonString);

import 'dart:convert';

CreateMatch createMatchFromJson(String str) => CreateMatch.fromJson(json.decode(str));

String createMatchToJson(CreateMatch data) => json.encode(data.toJson());

class CreateMatch {
    String title;
    int date;
    List<dynamic> inviteds;
    int game;
    int platform;

    CreateMatch({
        required this.title,
        required this.date,
        required this.inviteds,
        required this.game,
        required this.platform,
    });

    factory CreateMatch.fromJson(Map<String, dynamic> json) => CreateMatch(
        title: json["title"],
        date: json["date"],
        inviteds: List<dynamic>.from(json["inviteds"].map((x) => x)),
        game: json["game"],
        platform: json["platform"]
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "game": game,
        "platform": platform,
    };
}
