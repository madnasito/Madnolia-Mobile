// To parse this JSON data, do
//
//     final userMessagesBody = userMessagesBodyFromJson(jsonString);

import 'dart:convert';

UserMessagesBody userMessagesBodyFromJson(String str) => UserMessagesBody.fromJson(json.decode(str));

String userMessagesBodyToJson(UserMessagesBody data) => json.encode(data.toJson());

class UserMessagesBody {
    String user;
    int skip;

    UserMessagesBody({
        required this.user,
        required this.skip,
    });

    factory UserMessagesBody.fromJson(Map<String, dynamic> json) => UserMessagesBody(
        user: json["user"],
        skip: json["skip"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "skip": skip,
    };
}
