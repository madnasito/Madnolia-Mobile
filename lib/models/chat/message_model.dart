import 'dart:convert';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:madnolia/models/chat_user_model.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message extends Equatable {
  final String id;
  final String to;
  final ChatUser user;
  final String text;
  final DateTime date;
  final MessageType type;

  const Message({
    required this.id,
    required this.to,
    required this.user,
    required this.text,
    required this.date,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
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
    return Message(
      id: json["_id"],
      to: json["to"],
      user: ChatUser.fromJson(json["user"]),
      text: json["text"],
      date: DateTime.parse(json["date"]),
      type: messageType,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "to": to,
        "user": user.toJson(),
        "text": text,
        "date": date.toIso8601String(),
        "type": type.index,
      };

  @override
  List<Object> get props => [id, to, user, text, date, type];
}