// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

import 'package:Madnolia/models/chat_user_model.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  ChatUser user;
  int date;
  String text;
  String room;

  Message(
      {required this.user,
      required this.date,
      required this.text,
      required this.room});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      user: ChatUser.fromJson(json["user"]),
      date: json["date"],
      text: json["text"],
      room: json["room"]);

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "date": date,
        "text": text,
        "room": room,
      };
}
