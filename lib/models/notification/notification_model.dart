// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:madnolia/enums/notification_type.enum.dart';

import '../../database/database.dart' show NotificationCompanion;

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String id;
    String user;
    NotificationType type;
    String title;
    String thumb;
    String? sender;
    String path;
    bool read;
    DateTime date;

    NotificationModel({
        required this.id,
        required this.user,
        required this.type,
        required this.title,
        required this.thumb,
        this.sender,
        required this.path,
        required this.read,
        required this.date,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) {

      NotificationType type = NotificationType.values.firstWhere((e) => e.index == json["type"]);

      return NotificationModel(
        id: json["_id"],
        user: json["user"],
        type: type,
        title: json["title"],
        thumb: json["thumb"],
        sender: json["sender"],
        path: json["path"],
        read: json["read"],
        date: DateTime.parse(json["date"]),
    );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "type": type.index,
        "title": title,
        "thumb": thumb,
        "sender": sender,
        "path": path,
        "read": read,
        "date": date.toIso8601String(),
    };

    NotificationCompanion toCompanion() {
        return NotificationCompanion(
            id: drift.Value(id),
            type: drift.Value(type),
            title: drift.Value(title),
            thumb: drift.Value(thumb),
            sender: drift.Value(sender),
            path: drift.Value(path),
            read: drift.Value(read),
            date: drift.Value(date),
        );
    }
}
