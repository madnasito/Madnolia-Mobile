import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:madnolia/models/chat/individual_message_model.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:dio/dio.dart';
class MessagesService {

  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");


  Future<List> getMatchMessages(String id, int page) async{
    try {
      final url = Uri.parse("$baseUrl/messages/match?match=$id&skip=$page");

      final resp = await http.get(url);

      final jsonBody = jsonDecode(resp.body);

      final messages = jsonBody.map((e) => Message.fromJson(e)).toList();
      return messages;
    } catch (e) {
      return [];
    }
  }

  Future getUserChatMessages(UserMessagesBody message) async {
    try {
      final url = "$baseUrl/messages/chat";
      final String? token = await _storage.read(key: "token");

      final body = message.toJson();

      final resp = await Dio().post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

      final messages = resp.data.map((e) => IndividualMessage.fromJson(e)).toList();
      return messages;
    } catch (e) {
      return e;
    }
  }

}