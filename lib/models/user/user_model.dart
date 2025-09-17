// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/enums/user-availability.enum.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String id;
    String name;
    String username;
    String email;
    List<int> platforms;
    String image;
    String thumb;
    // List<String> games;
    int notifications;
    UserAvailability availability;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.platforms,
        required this.image,
        required this.thumb,
        // required this.games,
        required this.notifications,
        required this.availability,
    });

    factory User.fromJson(Map<String, dynamic> json) {
      final UserAvailability availability;

      switch (json['availability']) {
        case 0:
          availability = UserAvailability.everyone;
          break;
        case 1:
          availability = UserAvailability.partners;
          break;
        case 2:
          availability = UserAvailability.no;
          break;
        default:
          availability = UserAvailability.everyone;
      }

      return User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        platforms: List<int>.from(json["platforms"].map((x) => x)),
        image: json["image"],
        thumb: json["thumb"],
        // games: List<String>.from(json["games"].map((x) => x)),
        notifications: json["notifications"],
        availability: availability,
    );
    } 

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
        "image": image,
        "thumb": thumb,
        // "games": List<dynamic>.from(games.map((x) => x)),
        "notifications": notifications,
        "availability": availability.index,
    };
}
