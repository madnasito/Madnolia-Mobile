// To parse this JSON data, do
//
//     final connectionRequest = connectionRequestFromJson(jsonString);

import 'dart:convert';

ConnectionRequest connectionRequestFromJson(String str) => ConnectionRequest.fromJson(json.decode(str));

String connectionRequestToJson(ConnectionRequest data) => json.encode(data.toJson());

class ConnectionRequest {
    String sender;
    String receiver;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String id;

    ConnectionRequest({
        required this.sender,
        required this.receiver,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.id,
    });

    factory ConnectionRequest.fromJson(Map<String, dynamic> json) => ConnectionRequest(
        sender: json["sender"],
        receiver: json["receiver"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "_id": id,
    };
}
