// To parse this JSON data, do
//
//     final userMessagesBody = userMessagesBodyFromJson(jsonString);

import 'dart:convert';

UserMessagesBody userMessagesBodyFromJson(String str) => UserMessagesBody.fromJson(json.decode(str));

String userMessagesBodyToJson(UserMessagesBody data) => json.encode(data.toJson());

class UserMessagesBody {
    String user;
    // String? cursor;

    UserMessagesBody({
        required this.user,
        // this.cursor,
    });

    factory UserMessagesBody.fromJson(Map<String, dynamic> json) => UserMessagesBody(
        user: json["user"],
        // cursor: json["cursor"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        // "cursor": cursor,
    };
}
