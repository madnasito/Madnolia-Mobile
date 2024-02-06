// To parse this JSON data, do
//
//     final chatUser = chatUserFromJson(jsonString);

import 'dart:convert';

ChatUser chatUserFromJson(String str) => ChatUser.fromJson(json.decode(str));

String chatUserToJson(ChatUser data) => json.encode(data.toJson());

class ChatUser {
  String id;
  String name;
  String thumbImg;
  String username;

  ChatUser({
    required this.id,
    required this.name,
    required this.thumbImg,
    required this.username,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["_id"],
        name: json["name"],
        thumbImg: json["thumb_img"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "thumb_img": thumbImg,
        "username": username,
      };
}
