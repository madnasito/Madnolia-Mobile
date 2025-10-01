import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/models/game/platform_game.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/models/platform/platform_with_game_matches.dart';
import '../models/match/match_model.dart';


class MatchService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");

  final dio = Dio();

  // Getting the match
  // Future getMatch(String id) => matchGetRequest("info/$id");

  Future<Match> getMatch(String id) async{
    try {
      final response = await dio.get('$baseUrl/match/info/$id');

      return Match.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MatchWithGame>> getMatches(MatchesFilter payload) async {

    try {
      final String? token = await _storage.read(key: "token");
      
      Response response;

      response = await dio.get('$baseUrl/match/player-matches',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: payload.toJson()
      );

      final List<MatchWithGame> matches = (response.data as List)
        .map<MatchWithGame>((e) => MatchWithGame.fromJson(e))
        .toList();

      return matches;
    } catch (e) {
      rethrow;  
    }

  }

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

  Future cancellMatch(String id) async {
    try {
      
      final token = await _storage.read(key: "token");

      Response response = await dio.delete('$baseUrl/match/cancell/$id', options: Options(headers: {"Authorization": "Bearer $token"}));

      return response.data;
    } catch (e) {
      rethrow;
    }


  }

  Future leaveMatch(String id) async {
    try {
      final token = await _storage.read(key: 'token');

      final response  = await dio.patch('$baseUrl/match/leave/$id',
        options: Options(headers: {"Authorization": "Bearer $token"})
      );

      debugPrint(response.data);

      return response.data;

    } catch (e) {
      rethrow;
    }
  }

  Future join(String id) async {
    try {
      final token = await _storage.read(key: 'token');

      final response  = await dio.patch('$baseUrl/match/join/$id',
        options: Options(headers: {"Authorization": "Bearer $token"})
      );

      return response.data;

    } catch (e) {
      rethrow;
    }
  }

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

  Future<List<PlatformWithGameMatches>> getPlatformsWithGameMatches() async {
    final token = await _storage.read(key: "token");

    Response response = await dio.get(
      '$baseUrl/match/player-games-platforms',
      options: Options(headers: {"Authorization": "Bearer $token"})
    );

    return (response.data as List<dynamic>)
      .map((e) => PlatformWithGameMatches.fromJson(e))
      .toList();
  }

  Future<List<PlatformGame>> getGamesMatchesByPlatform({
  required int platformId,
  required int page,
  int limit = 5,
}) async {
  final token = await _storage.read(key: "token");
  final baseUrl = dotenv.get("API_URL");
  
  return await compute(_fetchGames, {
    'platformId': platformId,
    'page': page,
    'limit': limit,
    'token': token,
    'baseUrl': baseUrl,
  });
}

  static Future<List<PlatformGame>> _fetchGames(Map<String, dynamic> params) async{
  try {
    final dio = Dio();
    final response = await dio.get(
      '${params['baseUrl']}/match/platform',
      queryParameters: {
        'platform': params['platformId'],
        'skip': params['page'],
        'limit': params['limit'],
      },
      options: Options(headers: {"Authorization": "Bearer ${params['token']}"}),
    );

    return (response.data as List<dynamic>)
        .map((e) => PlatformGame.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch games');
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
