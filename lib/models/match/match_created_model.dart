// To parse this JSON data, do
//
//     final matchCreated = matchCreatedFromJson(jsonString);

import 'dart:convert';

MatchCreated matchCreatedFromJson(String str) => MatchCreated.fromJson(json.decode(str));

String matchCreatedToJson(MatchCreated data) => json.encode(data.toJson());

class MatchCreated {
    String game;
    int platform;
    int date;
    String user;
    List<dynamic> inviteds;
    String title;
    List<dynamic> likes;
    bool private;
    bool active;
    bool tournament;
    String id;

    MatchCreated({
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
        required this.id,
    });

    factory MatchCreated.fromJson(Map<String, dynamic> json) => MatchCreated(
        game: json["game"],
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
        inviteds: List<dynamic>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        private: json["private"],
        active: json["active"],
        tournament: json["tournament"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "game": game,
        "platform": platform,
        "date": date,
        "user": user,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "private": private,
        "active": active,
        "tournament": tournament,
        "_id": id,
    };
}
