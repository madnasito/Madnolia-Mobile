import 'package:dio/dio.dart' show Dio, Options;
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationsService {
  final _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.get("API_URL");

  Future<int> getNotificationsCount() async {
    try {
      final url = "$baseUrl/notifications/unread-count";

      final String? token = await _storage.read(key: "token");

      final resp = await Dio().get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

      return resp.data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}