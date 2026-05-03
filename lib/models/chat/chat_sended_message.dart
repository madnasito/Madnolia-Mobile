import 'dart:convert';

import 'package:madnolia/models/chat/chat_message_model.dart';

ChatMessageSendedI chatMessageSendedIFromJson(String str) =>
    ChatMessageSendedI.fromJson(json.decode(str));

String chatMessageSendedIToJson(ChatMessageSendedI data) =>
    json.encode(data.toJson());

class ChatMessageSendedI {
  String uid;
  ChatMessage message;

  ChatMessageSendedI({required this.uid, required this.message});

  factory ChatMessageSendedI.fromJson(Map<String, dynamic> json) =>
      ChatMessageSendedI(
        uid: json["uid"],
        message: ChatMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {"uid": uid, "message": message.toJson()};
}
