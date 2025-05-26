// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/enums/report-type.enum.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
    ReportType type;
    String user;
    String to;
    String description;
    String media;
    DateTime date;
    int status;
    String id;

    Report({
        required this.type,
        required this.user,
        required this.to,
        required this.description,
        required this.media,
        required this.date,
        required this.status,
        required this.id,
    });
    
    factory Report.fromJson(Map<String, dynamic> json) {
      // Convert numeric connection value to ConnectionStatus enum
      ReportType reportType;
      switch (json["type"]) {
        case 0:
          reportType = ReportType.spam;
          break;
        case 1:
          reportType = ReportType.childAbuse;
          break;
        default:
          reportType = ReportType.spam; // Default to none if value is unknown
          break;
      }

      return Report(
        type: reportType,
        user: json["user"],
        to: json["to"],
        description: json["description"],
        media: json["media"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        id: json["_id"],
      );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "user": user,
        "to": to,
        "description": description,
        "media": media,
        "date": date.toIso8601String(),
        "status": status,
        "_id": id,
    };
}
