import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/models/reports/dto/create_bug_report_dto.dart';
import 'package:madnolia/models/reports/dto/create_user_report_dto.dart';
import 'package:madnolia/models/reports/reports_model.dart';
import 'package:madnolia/models/reports/response/bug_report_response.dart';
import 'package:madnolia/models/reports/response/user_report_response.dart';
import 'package:madnolia/models/reports/upload-report.model.dart';

class ReportsService {
  final _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.get("API_URL");
  final dio = Dio();

  Future<Report> createReport(UploadReportBody body) async {
    try {
      final String? token = await _storage.read(key: "token");

      final formData = FormData.fromMap({
        'type': body.type.index.toString(),
        'to': body.to,
        'description': body.description,
        'media': await MultipartFile.fromFile(body.mediaPath),
      });

      final response = await dio.post(
        "$baseUrl/reports/create",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formData,
      );

      final Report report = Report.fromJson(response.data);

      return report;
    } catch (e) {
      rethrow;
    }
  }

  Future<BugReportResponse> createBugReport(CreateBugReportDto dto) async {
    try {
      final String? token = await _storage.read(key: "token");

      final formData = FormData.fromMap(dto.toJson());

      final response = await dio.post(
        "$baseUrl/reports/create-bug-report",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formData,
      );

      final BugReportResponse bugReportResponse = BugReportResponse.fromJson(
        response.data,
      );

      return bugReportResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserReportResponse> createUserResponse(CreateUserReportDto dto) async {
    try {
      final String? token = await _storage.read(key: "token");

      final formData = FormData.fromMap(dto.toJson());

      final response = await dio.post(
        "$baseUrl/reports/create-user-report",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formData,
      );

      final UserReportResponse userReportResponse = UserReportResponse.fromJson(
        response.data,
      );

      return userReportResponse;
    } catch (e) {
      rethrow;
    }
  }
}
