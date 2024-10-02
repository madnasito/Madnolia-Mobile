// To parse this JSON data, do
//
//     final createMessage = createMessageFromJson(jsonString);

import 'dart:convert';

CreateMessage createMessageFromJson(String str) => CreateMessage.fromJson(json.decode(str));

String createMessageToJson(CreateMessage data) => json.encode(data.toJson());

class CreateMessage {
    String room;
    String text;

    CreateMessage({
        required this.room,
        required this.text,
    });

    factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
        room: json["room"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "room": room,
        "text": text,
    };
}
