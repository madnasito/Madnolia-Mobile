// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/database/database.dart';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
    UserData user;
    int unreadCount;
    ChatMessageData message;

    UserChat({
        required this.user,
        required this.unreadCount,
        required this.message,
    });

    factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        user: json["user"],
        unreadCount: json["unreadCount"],
        message: ChatMessageData.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "unreadCount": unreadCount,
        "message": message.toJson(),
    };
}