// To parse this JSON data, do
//
//     final friendship = friendshipFromJson(jsonString);

import 'dart:convert';

Friendship friendshipFromJson(String str) => Friendship.fromJson(json.decode(str));

String friendshipToJson(Friendship data) => json.encode(data.toJson());

class Friendship {
    DateTime createdAt;
    String id;
    String user1;
    String user2;
    int status;

    Friendship({
        required this.createdAt,
        required this.id,
        required this.user1,
        required this.user2,
        required this.status,
    });

    factory Friendship.fromJson(Map<String, dynamic> json) => Friendship(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["_id"],
        user1: json["user1"],
        user2: json["user2"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "_id": id,
        "user1": user1,
        "user2": user2,
        "status": status,
    };
}
