// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String id;
    String name;
    String username;
    String email;
    bool status;
    List<int> platforms;
    String img;
    String thumb;
    List<String> partners;
    List<String> games;
    int notifications;
    int availability;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.status,
        required this.platforms,
        required this.img,
        required this.thumb,
        required this.partners,
        required this.games,
        required this.notifications,
        required this.availability,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        status: json["status"],
        platforms: List<int>.from(json["platforms"].map((x) => x)),
        img: json["img"],
        thumb: json["thumb"],
        partners: List<String>.from(json["partners"].map((x) => x)),
        games: List<String>.from(json["games"].map((x) => x)),
        notifications: json["notifications"],
        availability: json["availability"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "status": status,
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
        "img": img,
        "thumb": thumb,
        "partners": List<dynamic>.from(partners.map((x) => x)),
        "games": List<dynamic>.from(games.map((x) => x)),
        "notifications": notifications,
        "availability": availability,
    };
}
