import 'dart:convert';

import 'package:madnolia/models/chat/message_model.dart';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
    String id;
    String user;
    ChatMessage lastMessage;

    UserChat({
        required this.id,
        required this.user,
        required this.lastMessage,
    });

    factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["_id"],
        user: json["user"],
        lastMessage: ChatMessage.fromJson(json["lastMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "lastMessage": lastMessage.toJson(),
    };
}
