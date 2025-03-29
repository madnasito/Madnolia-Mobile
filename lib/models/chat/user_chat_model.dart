import 'dart:convert';

import 'package:madnolia/models/chat/individual_message_model.dart';
import 'package:madnolia/models/chat_user_model.dart';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
    ChatUser user;
    IndividualMessage lastMessage;

    UserChat({
        required this.user,
        required this.lastMessage,
    });

    factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        user: ChatUser.fromJson(json["user"]),
        lastMessage: IndividualMessage.fromJson(json["lastMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "lastMessage": lastMessage.toJson(),
    };
}
