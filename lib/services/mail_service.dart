import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:talker_dio_logger/talker_dio_logger.dart';

class MailService {
  final String baseUrl = dotenv.get("API_URL");

  final Dio dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printErrorData: true,
          printErrorMessage: true,
          printResponseData: false,
          printResponseMessage: false,
          printRequestData: false,
        ),
      ),
    );

  Future restorePassword(String email) async {
    try {
      final url = "$baseUrl/auth/recover-password-email";
      final Map<String, String> body = {"email": email};
      final resp = await dio.post(url, data: body);
      return resp.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
