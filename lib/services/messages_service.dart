import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:madnolia/models/chat/chat_message_model.dart';

import 'package:dio/dio.dart';

import '../models/chat/user_chat_model.dart';
class MessagesService {

  final _storage = const FlutterSecureStorage();

  final _dio = Dio();

  final String baseUrl = dotenv.get("API_URL");

  Future<List<ChatMessage>> syncFromDate({required DateTime date }) async {
    try {

      final String url = "$baseUrl/messages/sync-from";
      final Map<String, String> queryParams = {
        'date': date.toIso8601String(),
      };

      final String? token = await _storage.read(key: "token");

      final resp = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: {"Authorization": "Bearer $token"})
      );


      return (resp.data as List).map((e) => ChatMessage.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<ChatMessage>> getMatchMessages(String id, String? cursor) async {
  try {
    final Map<String, String> queryParams = {
      'match': id,
    };
    if (cursor != null) {
      queryParams['cursor'] = cursor;
    }
    
    final String? token = await _storage.read(key: "token");
    final url = "$baseUrl/messages/match";
    final resp = await _dio.get(
      url,
      queryParameters: queryParams,
      options: Options(headers: {"Authorization": "Bearer $token"})
    );

    return (resp.data as List).map((e) => ChatMessage.fromJson(e)).toList();
  } catch (e) {
    rethrow;
  }
}

  Future<List<ChatMessage>> getUserChatMessages(String userId, String? cursor) async {
    try {
      final url = "$baseUrl/messages/chat";
      final String? token = await _storage.read(key: "token");

      final Map<String, String> queryParams = {
        'conversation': userId,
      };
      if (cursor != null) {
        queryParams['cursor'] = cursor;
      }

      final resp = await _dio.post(
        url,
        data: queryParams,
        options: Options(headers: {"Authorization": "Bearer $token"}
        )
      );

      return (resp.data as List).map((e) => ChatMessage.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserChatModel>> getChats(int page) async {
    try {
      final url = "$baseUrl/messages";
      final String? token = await _storage.read(key: "token");
      final resp = await _dio.get(
        url, 
        options: Options(headers: {"Authorization": "Bearer $token"})
      );

      // Explicit type casting solution
      final List<UserChatModel> chats = (resp.data as List)
          .map<UserChatModel>((e) => UserChatModel.fromJson(e))
          .toList();

      return chats;
    } catch (e) {
      throw ArgumentError(e.toString()); // Better to convert error to string
    }
  }

  
}