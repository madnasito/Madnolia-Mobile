// To parse this JSON data, do
//
//     final userReportResponse = userReportResponseFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/models/reports/enum/report_status.dart';
import 'package:madnolia/models/reports/enum/user_report_type.dart';

UserReportResponse userReportResponseFromJson(String str) =>
    UserReportResponse.fromJson(json.decode(str));

String userReportResponseToJson(UserReportResponse data) =>
    json.encode(data.toJson());

class UserReportResponse {
  UserReportType type;
  String user;
  String to;
  String description;
  String media;
  DateTime date;
  ReportStatus status;
  String id;

  UserReportResponse({
    required this.type,
    required this.user,
    required this.to,
    required this.description,
    required this.media,
    required this.date,
    required this.status,
    required this.id,
  });

  factory UserReportResponse.fromJson(Map<String, dynamic> json) =>
      UserReportResponse(
        type: UserReportType.values[json["type"]],
        user: json["user"],
        to: json["to"],
        description: json["description"],
        media: json["media"],
        date: DateTime.parse(json["date"]),
        status: ReportStatus.values[json["status"]],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "type": type.index,
    "user": user,
    "to": to,
    "description": description,
    "media": media,
    "date": date.toIso8601String(),
    "status": status.index,
    "_id": id,
  };
}
