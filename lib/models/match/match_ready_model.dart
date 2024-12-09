// To parse this JSON data, do
//
//     final matchReady = matchReadyFromJson(jsonString);

import 'dart:convert';

MatchReady matchReadyFromJson(String str) => MatchReady.fromJson(json.decode(str));

String matchReadyToJson(MatchReady data) => json.encode(data.toJson());

class MatchReady {
    String title;
    String match;

    MatchReady({
        required this.title,
        required this.match,
    });

    factory MatchReady.fromJson(Map<String, dynamic> json) => MatchReady(
        title: json["title"],
        match: json["match"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "match": match,
    };
}
