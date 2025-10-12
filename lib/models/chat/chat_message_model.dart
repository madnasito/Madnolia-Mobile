// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';

class ChatMessage {
    String id;
    ChatMessageStatus status;
    String content;
    ChatMessageType type;
    String conversation;
    String creator;
    DateTime date;
    DateTime updatedAt;

    ChatMessage({
        required this.id,
        required this.status,
        required this.content,
        required this.type,
        required this.conversation,
        required this.creator,
        required this.date,
        required this.updatedAt,
    });

    factory ChatMessage.fromJson(Map<String, dynamic> json) {
      ChatMessageType messageType;
      ChatMessageStatus messageStatus;
      
      switch (json["type"]) {
        case 0:
          messageType = ChatMessageType.user;
          break;
        case 1:
          messageType = ChatMessageType.group;
          break;
        case 2:
          messageType = ChatMessageType.match;
          break;
        default:
          messageType = ChatMessageType.user;
          break;
      }

      switch (json["status"]) {
        case 0:
          messageStatus = ChatMessageStatus.sent;
          break;
        case 1:
          messageStatus = ChatMessageStatus.delivered;
          break;
        case 2:
          messageStatus = ChatMessageStatus.read;
          break;
        case 3:
          messageStatus = ChatMessageStatus.deleted;
          break;
        default:
          messageStatus = ChatMessageStatus.sent;
          break;
      }
      
      return ChatMessage(
        id: json["id"],
        status: messageStatus,
        content: json["content"],
        type: messageType,
        conversation: json["conversation"],
        creator: json["creator"],
        date: DateTime.parse(json["date"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status.index,  // Convert enum to its index
        "content": content,
        "type": type.index,      // Convert enum to its index
        "conversation": conversation,
        "creator": creator,
        "date": date.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };

    ChatMessageCompanion toCompanion() {
      return ChatMessageCompanion(
        id: Value(id),
        status: Value(status),
        content: Value(content),
        conversation: Value(conversation),
        creator: Value(creator),
        date: Value(date),
        updatedAt: Value(updatedAt)
      );
    }
}

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());
ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));
