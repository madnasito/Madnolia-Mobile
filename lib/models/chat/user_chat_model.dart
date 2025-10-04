// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/chat/chat_message_model.dart';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
    String id;
    int unreadCount;
    ChatMessage message;

    UserChat({
        required this.id,
        required this.unreadCount,
        required this.message,
    });

    factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["_id"],
        unreadCount: json["unreadCount"],
        message: ChatMessage.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "unreadCount": unreadCount,
        "message": message.toJson(),
    };
}