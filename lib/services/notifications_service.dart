import 'package:dio/dio.dart' show Dio, Options;
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:madnolia/models/notification/notification_model.dart';


class NotificationsService {
  
  final _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.get("API_URL");
  final dio = Dio();

  Future<List<NotificationModel>> getUserNotifications() async {
    try {
      final String? token = await _storage.read(key: "token");

      final response = await dio.get("$baseUrl/notifications", options: Options(headers: {"Authorization": "Bearer $token"}));

      List<NotificationModel> notifications = List<Map<String, dynamic>>.from(response.data)
      .map((e) => NotificationModel.fromJson(e))
      .toList();

      return notifications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> getNotificationsCount() async {
    try {
      final url = "$baseUrl/notifications/unread-count";

      final String? token = await _storage.read(key: "token");

      final resp = await Dio().get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

      return int.parse(resp.data);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}