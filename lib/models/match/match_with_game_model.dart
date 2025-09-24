// To parse this JSON data, do
//
//     final MatchWithGame = MatchWithGameFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/models/game/game_model.dart';

MatchWithGame matchWithGameFromJson(String str) => MatchWithGame.fromJson(json.decode(str));

String matchWithGameToJson(MatchWithGame data) => json.encode(data.toJson());

class MatchWithGame {
    String id;
    String description;
    Game game;
    int platform;
    int date;
    String user;
    List<String> inviteds;
    String title;
    List<String> joined;
    bool private;
    String? tournament;
    MatchStatus status;

    MatchWithGame({
        required this.id,
        required this.description,
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

    factory MatchWithGame.fromJson(Map<String, dynamic> json) {

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

      return MatchWithGame(
        id: json["_id"],
        game: Game.fromJson(json["game"]),
        platform: json["platform"],
        date: json["date"],
        user: json["user"],
        inviteds: List<String>.from(json["inviteds"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        joined: List<String>.from(json["joined"].map((x) => x)),
        private: json["private"],
        status: matchStatus,
        tournament: json["tournament"],
    );
    } 

    Map<String, dynamic> toJson() => {
        "_id": id,
        "game": game.toJson(),
        "platform": platform,
        "date": date,
        "user": user,
        "description": description,
        "inviteds": List<dynamic>.from(inviteds.map((x) => x)),
        "title": title,
        "joined": List<dynamic>.from(joined.map((x) => x)),
        "private": private,
        "status": status,
        "tournament": tournament,
    };
}