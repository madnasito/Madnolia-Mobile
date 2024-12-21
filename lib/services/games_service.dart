import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/global/environment.dart';

class GamesService {
  final _storage = const FlutterSecureStorage();

  Future getGameInfo(String game) async {
    try {
      final url = Uri.parse("${Environment.apiUrl}/games/$game");

      final token = await _storage.read(key: "token");
      final resp = await http.get(url, headers: {"token": token!});

      debugPrint("Getting game info");
      return jsonDecode(resp.body);
    } catch (e) {
      debugPrint(e as String?);
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future getPlatformGameMatches(int platformId, int gameId) async {
    try {
      final url = Uri.parse(
          "${Environment.apiUrl}/matches_of_game/$platformId/$gameId");

      final resp = await http.get(url);

      return jsonDecode(resp.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
