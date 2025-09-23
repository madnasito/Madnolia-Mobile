// To parse this JSON data, do
//
//     final simpleUser = simpleUserFromJson(jsonString);

import 'dart:convert';
import 'package:madnolia/enums/connection-status.enum.dart';

import '../../database/drift/database.dart';

SimpleUser simpleUserFromJson(String str) => SimpleUser.fromJson(json.decode(str));

String simpleUserToJson(SimpleUser data) => json.encode(data.toJson());

class SimpleUser {
  String id;
  String name;
  String username;
  String thumb;
  ConnectionStatus connection;

  SimpleUser({
    required this.id,
    required this.name,
    required this.username,
    required this.thumb,
    required this.connection,
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    // Convert numeric connection value to ConnectionStatus enum
    ConnectionStatus connectionStatus;
    switch (json["connection"]) {
      case 0:
        connectionStatus = ConnectionStatus.none;
        break;
      case 1:
        connectionStatus = ConnectionStatus.requestSent;
        break;
      case 2:
        connectionStatus = ConnectionStatus.requestReceived;
        break;
      case 3:
        connectionStatus = ConnectionStatus.partner;
        break;
      case 4:
        connectionStatus = ConnectionStatus.blocked;
        break;
      default:
        connectionStatus = ConnectionStatus.none; // Default to none if value is unknown
        break;
    }

    return SimpleUser(
      id: json["_id"],
      name: json["name"],
      username: json["username"],
      thumb: json["thumb"],
      connection: connectionStatus,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "thumb": thumb,
    "connection": connection.index, // Send the index of the enum value
  };

  factory SimpleUser.fromUserData(UserData userData) {
    return SimpleUser(
      id: userData.id,
      name: userData.name,
      username: userData.username,
      thumb: userData.thumb,
      connection: userData.connection,
    );
  }
}
