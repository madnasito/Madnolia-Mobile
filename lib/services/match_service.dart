import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class MatchService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");

  // Getting the match
  Future getMatch(String id) => matchGetRequest("info/$id");

  // Getting the match
  Future getMatchWithGame(String id) => matchGetRequest("with-game/$id");

  // Getting the match
  Future getFullMatch(String id) => matchGetRequest("full/$id");

  // Get all matches created by an user
  Future getUserMatches() => matchGetRequest("player-matches");

  // Get all matches joined
  Future getJoinedMatches() => matchGetRequest("joined");

  Future getGamesRecomendations(int platform) => matchGetRequest("latest-games/$platform");

  // Get all matches by a platform
  Future<List> getMatchesByPlatform(int platform) =>
      matchGetListRequest("platform/$platform");

  // Get a game match specifing a game & platform
  Future getMatchesByPlatformAndGame(int platform, String game) =>
      matchGetListRequest("by-platform-and-game/$platform/$game");

  Future createMatch(Map match) => matchPostRequest("create", match);

  Future editMatch(String id, Map body) => matchPatchRequest("update/$id", body);

  Future deleteMatch(String id) => matchDeleteRequest("delete/$id");

  Future matchGetRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/match/$apiUrl");

      final resp =
          await http.get(url, headers: {"Authorization": "Bearer $token"});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"message": "NETWORK_ERROR", "error": "Network error"};
    }
  }

  Future<List> matchGetListRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/match/$apiUrl");

      final resp =
          await http.get(url, headers: {"Authorization": "Bearer $token"});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> matchPostRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/match/$apiUrl");

      final resp = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(body));

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map> matchPatchRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/match/$apiUrl");

      final resp = await http.patch(url,
          headers: {
            "Authorization": "Bearer $token"
          }, body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map> matchDeleteRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/match/$apiUrl");

      final resp = await http
          .delete(url, headers: {"Authorization": "Bearer $token"});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }
}
