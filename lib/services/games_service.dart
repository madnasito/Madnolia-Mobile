import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:Madnolia/global/environment.dart';

class GamesService {
  final _storage = const FlutterSecureStorage();

  Future getHomeGames() async {
    try {
      final url = Uri.parse("${Environment.apiUrl}/home/user-matches");

      final token = await _storage.read(key: "token");
      final resp = await http.get(url, headers: {"token": token!});

      return jsonDecode(resp.body);
    } catch (e) {}
  }

  Future getPlatformGameMatches(int platformId, int gameId) async {
    try {
      final url = Uri.parse(
          "${Environment.apiUrl}/matches_of_game/$platformId/$gameId");

      final resp = await http.get(url);

      return jsonDecode(resp.body);
    } catch (e) {}
  }
}
