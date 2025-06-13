import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/models/game/game_model.dart';

class GamesService {
  final _storage = const FlutterSecureStorage();
  final _dio = Dio();

  final String apiUrl = dotenv.get("API_URL");
  Future<Game> getGameInfoBySlug(String gameSlug) async {
    try {
      final url = "$apiUrl/games/$gameSlug";

      final token = await _storage.read(key: "token");
      final response = await _dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

      debugPrint("Getting game info");
      final game = Game.fromJson(response.data);
      return game;
    } catch (e) {
      debugPrint(e as String?);
      throw {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Game> getGameInfoById(String id) async {
    try {
      final url = "$apiUrl/games/id/$id";

      final token = await _storage.read(key: "token");
      final response = await _dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

      debugPrint("Getting game info");
      final game = Game.fromJson(response.data);
      return game;
    } catch (e) {
      debugPrint(e as String?);
      throw {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future getPlatformGameMatches(int platformId, int gameId) async {
    try {
      final url = Uri.parse(
          "$apiUrl/matches_of_game/$platformId/$gameId");

      final resp = await http.get(url);

      return jsonDecode(resp.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
