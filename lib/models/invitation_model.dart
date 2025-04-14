// To parse this JSON data, do
//
//     final invitation = invitationFromJson(jsonString);

import 'dart:convert';

Invitation invitationFromJson(String str) =>
    Invitation.fromJson(json.decode(str));

String invitationToJson(Invitation data) => json.encode(data.toJson());

class Invitation {
  String name;
  String url;
  String match;
  String img;
  String user;

  Invitation({
    required this.name,
    required this.url,
    required this.match,
    required this.img,
    required this.user
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        name: json["name"],
        url: json["url"],
        match: json["match"],
        img: json["img"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "match": match,
        "img": img,
        "user": user,
      };
}
