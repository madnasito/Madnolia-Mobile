import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:dio/dio.dart';

import '../models/chat/user_chat_model.dart';
class MessagesService {

  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");


  Future<List<ChatMessage>> getMatchMessages(String id, int page) async {
  try {
    final url = Uri.parse("$baseUrl/messages/match?match=$id&skip=$page");
    final resp = await http.get(url);

    // Ensure response is successful
    if (resp.statusCode != 200) {
      throw Exception('Failed to load messages: ${resp.statusCode}');
    }

    // Explicitly type the decoded JSON
    final List<dynamic> jsonBody = jsonDecode(resp.body);

    // Properly convert each item to GroupMessage
    final List<ChatMessage> messages = jsonBody
        .map<ChatMessage>((dynamic e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList();

    return messages;
  } catch (e) {
    throw Exception('Failed to fetch match messages: $e');
  }
}

  Future getUserChatMessages(UserMessagesBody messagesBody) async {
    try {
      final url = "$baseUrl/messages/chat";
      final String? token = await _storage.read(key: "token");

      final body = messagesBody.toJson();

      final resp = await Dio().post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

      final messages = resp.data.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
      return messages;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserChat>> getChats(int page) async {
  try {
      final url = "$baseUrl/messages";
      final String? token = await _storage.read(key: "token");
      final resp = await Dio().get(
        url, 
        options: Options(headers: {"Authorization": "Bearer $token"})
      );

      // Explicit type casting solution
      final List<UserChat> chats = (resp.data as List)
          .map<UserChat>((e) => UserChat.fromJson(e))
          .toList();

      return chats;
    } catch (e) {
      throw ArgumentError(e.toString()); // Better to convert error to string
    }
  }

}