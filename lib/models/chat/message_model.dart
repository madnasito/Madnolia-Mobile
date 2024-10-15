// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/chat_user_model.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
    String id;
    String room;
    ChatUser user;
    String text;
    DateTime date;

    Message({
        required this.id,
        required this.room,
        required this.user,
        required this.text,
        required this.date,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        room: json["room"],
        user: ChatUser.fromJson(json["user"]),
        text: json["text"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "room": room,
        "user": user.toJson(),
        "text": text,
        "date": date.toIso8601String(),
    };
}
