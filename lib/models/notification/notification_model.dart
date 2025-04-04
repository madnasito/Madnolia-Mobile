// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String id;
    String user;
    int type;
    String title;
    String thumb;
    String subtitle;
    String path;
    bool read;
    DateTime date;

    NotificationModel({
        required this.id,
        required this.user,
        required this.type,
        required this.title,
        required this.thumb,
        required this.subtitle,
        required this.path,
        required this.read,
        required this.date,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["_id"],
        user: json["user"],
        type: json["type"],
        title: json["title"],
        thumb: json["thumb"],
        subtitle: json["subtitle"],
        path: json["path"],
        read: json["read"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "type": type,
        "title": title,
        "thumb": thumb,
        "subtitle": subtitle,
        "path": path,
        "read": read,
        "date": date.toIso8601String(),
    };
}
