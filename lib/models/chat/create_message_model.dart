import 'dart:convert';

import '../../enums/message_type.enum.dart';

// Extension to convert MessageType to integer and vice versa
extension MessageTypeExtension on MessageType {
  int get value {
    switch (this) {
      case MessageType.user:
        return 0;
      case MessageType.group:
        return 1;
      case MessageType.match:
        return 2;
      
    }
  }

  static MessageType fromInt(int value) {
    switch (value) {
      case 0:
        return MessageType.user;
      case 1:
        return MessageType.group;
      case 2:
        return MessageType.match;
      default:
        throw ArgumentError("Invalid MessageType integer value: $value");
    }
  }
}

CreateMessage createMessageFromJson(String str) =>
    CreateMessage.fromJson(json.decode(str));

String createMessageToJson(CreateMessage data) => json.encode(data.toJson());

class CreateMessage {
  String to;
  String text;
  MessageType type; // Use the enum directly

  CreateMessage({
    required this.to,
    required this.text,
    required this.type,
  });

  factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
        to: json["to"],
        text: json["text"],
        type: MessageTypeExtension.fromInt(json["type"]), // Convert int to enum
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "text": text,
        "type": type.value, // Convert enum to int
      };
}