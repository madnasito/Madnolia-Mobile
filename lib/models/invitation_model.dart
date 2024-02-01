// To parse this JSON data, do
//
//     final invitation = invitationFromJson(jsonString);

import 'dart:convert';

Invitation invitationFromJson(String str) =>
    Invitation.fromJson(json.decode(str));

String invitationToJson(Invitation data) => json.encode(data.toJson());

class Invitation {
  String name;
  String matchUrl;
  String match;
  String img;

  Invitation({
    required this.name,
    required this.matchUrl,
    required this.match,
    required this.img,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        name: json["name"],
        matchUrl: json["match_url"],
        match: json["match"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "match_url": matchUrl,
        "match": match,
        "img": img,
      };
}
