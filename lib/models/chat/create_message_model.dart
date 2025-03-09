// To parse this JSON data, do
//
//     final createMessage = createMessageFromJson(jsonString);

import 'dart:convert';

CreateMessage createMessageFromJson(String str) => CreateMessage.fromJson(json.decode(str));

String createMessageToJson(CreateMessage data) => json.encode(data.toJson());

class CreateMessage {
    String to;
    String text;

    CreateMessage({
        required this.to,
        required this.text,
    });

    factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
        to: json["to"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "to": to,
        "text": text,
    };
}
