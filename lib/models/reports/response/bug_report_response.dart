// To parse this JSON data, do
//
//     final bugReportResponse = bugReportResponseFromJson(jsonString);

import 'dart:convert';

import '../enum/bug_report_type.dart';
import '../enum/report_status.dart';

BugReportResponse bugReportResponseFromJson(String str) =>
    BugReportResponse.fromJson(json.decode(str));

String bugReportResponseToJson(BugReportResponse data) =>
    json.encode(data.toJson());

class BugReportResponse {
  BugReportType type;
  String user;
  String description;
  String media;
  DateTime date;
  ReportStatus status;
  String id;

  BugReportResponse({
    required this.type,
    required this.user,
    required this.description,
    required this.media,
    required this.date,
    required this.status,
    required this.id,
  });

  factory BugReportResponse.fromJson(Map<String, dynamic> json) =>
      BugReportResponse(
        type: BugReportType.values[json["type"]],
        user: json["user"],
        description: json["description"],
        media: json["media"],
        date: DateTime.parse(json["date"]),
        status: ReportStatus.values[json["status"]],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "type": type.index,
    "user": user,
    "description": description,
    "media": media,
    "date": date.toIso8601String(),
    "status": status.index,
    "_id": id,
  };
}
