import 'dart:convert';

import 'package:madnolia/enums/match-status.enum.dart';

import '../../enums/platforms_id.enum.dart';

Match matchFromJson(String str) => Match.fromJson(json.decode(str));

String matchToJson(Match data) => json.encode(data.toJson());

class Match {
    String id;
    String game;
    PlatformId platform;
    int date;
    String user;
    List<String> inviteds;
    String title;
    String description;
    int duration;
    List<String> joined;
    bool private;
    String? tournament;
    MatchStatus status;

    Match({
        required this.id,
        required this.game,
        required this.platform,
        required this.date,
        required this.user,
        required this.inviteds,
        required this.title,
        required this.description,
        required this.duration,
        required this.joined,
        required this.private,
        required this.tournament,
        required this.status
    });

    factory Match.fromJson(Map<String, dynamic> json) {

      MatchStatus matchStatus;

      switch (json["status"]) {
        case 0:
          matchStatus = MatchStatus.waiting;
          break;
        case 1:
          matchStatus = MatchStatus.running;
          break;
        case 2:
          matchStatus = MatchStatus.finished;
          break;
        case 3:
          matchStatus = MatchStatus.cancelled;
          break;
        default:
          matchStatus = MatchStatus.waiting;
          break;
      }

      return Match(
        id: json["_id"],
        game: json["game"],
        platform: PlatformId.values.firstWhere((e) => e.id == json["platform"]),
        date: json["date"],
        user: json["user"],
        inviteds: List<String>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        joined: List<String>.from(json["joined"].map((x) => x)),
        private: json["private"],
        tournament: json["tournament"],
        status: matchStatus
      );

    } 
    Map<String, dynamic> toJson() => {
        "_id": id,
        "game": game,
        "platform": platform.id,
        "date": date,
        "user": user,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "description": description,
        "duration": duration,
        "joined": List<dynamic>.from(joined.map((x) => x)),
        "private": private,
        "tournament": tournament,
        "status": status,
    };
}
