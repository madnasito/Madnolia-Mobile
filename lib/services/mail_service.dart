import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

class MailService {

  final String baseUrl = dotenv.get("API_URL");

  Future restorePassword(String email) async {
    try {
      final url = "$baseUrl/mail/reset-password";
      final Map<String, String> body = {"email": email };
      final resp = await Dio().get(url, data: body);
      return resp.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}