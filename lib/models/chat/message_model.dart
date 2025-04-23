import 'dart:convert';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:equatable/equatable.dart';

ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage extends Equatable {
  final String id;
  final String to;
  final String user;
  final String text;
  final DateTime date;
  final MessageType type;

  const ChatMessage({
    required this.id,
    required this.to,
    required this.user,
    required this.text,
    required this.date,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    MessageType messageType;
    switch (json["type"]) {
      case 0:
        messageType = MessageType.user;
        break;
      case 1:
        messageType = MessageType.group;
        break;
      case 2:
        messageType = MessageType.match;
        break;
      default:
        messageType = MessageType.user;
        break;
    }
    return ChatMessage(
      id: json["_id"],
      to: json["to"],
      user: json["user"],
      text: json["text"],
      date: DateTime.parse(json["date"]),
      type: messageType,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "to": to,
        "user": user,
        "text": text,
        "date": date.toIso8601String(),
        "type": type.index,
      };

  @override
  List<Object> get props => [id, to, user, text, date, type];
}