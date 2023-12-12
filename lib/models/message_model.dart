// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  User user;
  int date;
  String text;

  Message({
    required this.user,
    required this.date,
    required this.text,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        user: User.fromJson(json["user"]),
        date: json["date"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "date": date,
        "text": text,
      };
}

class User {
  String thumbImg;
  String id;
  String name;
  String username;

  User({
    required this.thumbImg,
    required this.id,
    required this.name,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        thumbImg: json["thumb_img"],
        id: json["_id"],
        name: json["name"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "thumb_img": thumbImg,
        "_id": id,
        "name": name,
        "username": username,
      };
}
