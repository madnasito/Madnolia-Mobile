import 'package:dio/dio.dart' show Dio, Options;
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:madnolia/models/friendship/friendship_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class FriendshipService {
  final _storage = const FlutterSecureStorage();

  final String baseUrl = '${dotenv.get("API_URL")}/friendship';

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

  Future<List<Friendship>> getAllFriendships({int page = 1}) async {
    try {
      final url = "$baseUrl/all";

      final String? token = await _storage.read(key: 'token');

      final resp = await dio.get(
        url,
        options: Options(headers: {"Authorization": 'Bearer $token'}),
        queryParameters: {"page": page},
      );

      final List<Friendship> friendships = (resp.data as List)
          .map((f) => Friendship.fromJson(f))
          .toList();
      return friendships;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Friendship> getFriendwhipWithUser(String userId) async {
    try {
      final url = "$baseUrl/with?user=$userId";
      final String? token = await _storage.read(key: "token");

      final resp = await dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final Friendship friendship = Friendship.fromJson(resp.data);

      return friendship;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Friendship> getFriendshipById(String id) async {
    try {
      final url = "$baseUrl/get?id=$id";

      final String? token = await _storage.read(key: 'token');

      final resp = await dio.get(
        url,
        options: Options(headers: {"Authorization": 'Bearer $token'}),
      );

      final Friendship friendship = Friendship.fromJson(resp.data);

      return friendship;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Friendship>> getFriendshipsByIds(List<String> ids) async {
    try {
      final url = "$baseUrl/friendships-by-ids";

      final String? token = await _storage.read(key: 'token');

      final resp = await dio.post(
        url,
        options: Options(headers: {"Authorization": 'Bearer $token'}),
        data: {"ids": ids},
      );

      final List<Friendship> friendships = (resp.data as List)
          .map((f) => Friendship.fromJson(f))
          .toList();

      return friendships;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
