import 'package:dio/dio.dart' show Dio, Options;
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:madnolia/models/friendship/friendship_model.dart';

class FriendshipService {
  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");

  Future<Friendship> getFriendwhipWithUser(String userId) async {

    try {
      
      final url = "$baseUrl/friendship/with?user=$userId";
      final String? token = await _storage.read(key: "token");

      final resp = await Dio().get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

      final Friendship friendship = Friendship.fromJson(resp.data);

      return friendship;
    } catch (e) {
      throw Exception(e);
    }

  }
}