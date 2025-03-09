// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    List<dynamic> partners;
    int notifications;
    String id;
    String name;
    String username;
    String email;
    List<int> platforms;
    String img;
    String thumb;
    int availability;

    User({
        required this.partners,
        required this.notifications,
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.platforms,
        required this.img,
        required this.thumb,
        required this.availability,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        partners: List<dynamic>.from(json["partners"].map((x) => x)),
        notifications: json["notifications"],
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        platforms: List<int>.from(json["platforms"].map((x) => x)),
        img: json["img"],
        thumb: json["thumb"],
        availability: json["availability"],
    );

    Map<String, dynamic> toJson() => {
        "partners": List<dynamic>.from(partners.map((x) => x)),
        "notifications": notifications,
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
        "img": img,
        "thumb": thumb,
        "availability": availability,
    };
}
