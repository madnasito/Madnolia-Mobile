import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class MatchService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  // Getting the match
  Future<Map> getMatch(String id) => matchGetRequest("match/$id");

  // Get all matches created by an user
  Future<Map> getUserMatches() => matchGetRequest("player_matches");

  // Get all matches by a platform
  Future<Map> getMatchesByPlatform(String platform) =>
      matchGetRequest("player/matches_of/$platform");

  // Get a game match specifing a game & platform
  Future<Map> getMatchesByGameAndPlatform(String game, String platform) =>
      matchGetRequest("matches_of_game/$platform/$game");

  Future<Map> createMatch(Map match) => matchPostRequest("match", match);

  Future<Map> editMatch(Map match) => matchPutRequest("edit_match", match);

  Future<Map> deleteMatch(String id) => matchDeleteRequest("delete_match/$id");

  Future<Map> matchGetRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp =
          await http.get(url, headers: {"token": (token != null) ? token : ""});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"ok": false};
    }
  }

  Future<Map> matchPostRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http.post(url,
          headers: {"token": (token != null) ? token : ""}, body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"ok": false};
    }
  }

  Future<Map> matchPutRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http.put(url,
          headers: {"token": (token != null) ? token : ""}, body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"ok": false};
    }
  }

  Future<Map> matchDeleteRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http
          .delete(url, headers: {"token": (token != null) ? token : ""});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"ok": false};
    }
  }
}
