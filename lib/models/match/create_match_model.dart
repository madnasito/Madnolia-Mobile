// To parse this JSON data, do
//
//     final createMatch = createMatchFromJson(jsonString);

import 'dart:convert';

CreateMatch createMatchFromJson(String str) => CreateMatch.fromJson(json.decode(str));

String createMatchToJson(CreateMatch data) => json.encode(data.toJson());

class CreateMatch {
    String title;
    String description;
    DateTime date;
    List<String> inviteds;
    int game;
    int platform;
    int duration;

    CreateMatch({
        required this.title,
        required this.description,
        required this.date,
        required this.inviteds,
        required this.game,
        required this.platform,
        required this.duration
    });

    factory CreateMatch.fromJson(Map<String, dynamic> json) => CreateMatch(
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        inviteds: List<String>.from(json["inviteds"].map((x) => x)),
        game: json["game"],
        platform: json["platform"],
        duration: json["duration"]
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "game": game,
        "platform": platform,
        "duration": duration,
    };
}
