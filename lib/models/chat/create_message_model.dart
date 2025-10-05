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
  String id;
  String conversation;
  String content;
  MessageType type; // Use the enum directly

  CreateMessage({
    required this.id,
    required this.conversation,
    required this.content,
    required this.type,
  });

  factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
    id: json["id"],
    conversation: json["conversation"],
    content: json["content"],
    type: MessageTypeExtension.fromInt(json["type"]), // Convert int to enum
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation": conversation,
    "content": content,
    "type": type.value, // Convert enum to int
  };
}