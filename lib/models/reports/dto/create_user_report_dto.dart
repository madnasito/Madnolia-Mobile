import 'dart:convert';

import 'package:dio/dio.dart' show MultipartFile;
import 'package:madnolia/models/reports/enum/user_report_type.dart';

CreateUserReportDto createUserReportFromJson(String str) =>
    CreateUserReportDto.fromJson(json.decode(str));

String createUserReportToJson(CreateUserReportDto data) =>
    json.encode(data.toJson());

class CreateUserReportDto {
  UserReportType type;
  String to;
  String description;
  MultipartFile media;

  CreateUserReportDto({
    required this.type,
    required this.to,
    required this.description,
    required this.media,
  });

  factory CreateUserReportDto.fromJson(Map<String, dynamic> json) =>
      CreateUserReportDto(
        type: UserReportType.values[json["type"]],
        to: json["to"],
        description: json["description"],
        media: MultipartFile.fromBytes(json["media"]),
      );

  Map<String, dynamic> toJson() => {
    "type": type.index,
    "to": to,
    "description": description,
    "media": media,
  };
}
