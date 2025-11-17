// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/chat/chat_message_model.dart';

UserChatModel userChatFromJson(String str) => UserChatModel.fromJson(json.decode(str));

String userChatToJson(UserChatModel data) => json.encode(data.toJson());

class UserChatModel {
    String id;
    int unreadCount;
    ChatMessage message;

    UserChatModel({
        required this.id,
        required this.unreadCount,
        required this.message,
    });

    factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
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