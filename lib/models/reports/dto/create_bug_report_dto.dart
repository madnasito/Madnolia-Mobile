// To parse this JSON data, do
//
//     final createBugReport = createBugReportFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

import '../enum/bug_report_type.dart';

CreateBugReportDto createBugReportFromJson(String str) =>
    CreateBugReportDto.fromJson(json.decode(str));

String createBugReportToJson(CreateBugReportDto data) =>
    json.encode(data.toJson());

class CreateBugReportDto {
  BugReportType type;
  String description;
  MultipartFile media;

  CreateBugReportDto({
    required this.type,
    required this.description,
    required this.media,
  });

  factory CreateBugReportDto.fromJson(Map<String, dynamic> json) =>
      CreateBugReportDto(
        type: BugReportType.values[json["type"]],
        description: json["description"],
        media: MultipartFile.fromBytes(json["media"]),
      );

  Map<String, dynamic> toJson() => {
    "type": type.index,
    "description": description,
    "media": media,
  };
}
