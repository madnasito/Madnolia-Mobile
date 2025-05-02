import 'dart:convert';
import 'package:dio/dio.dart' show Dio, Options;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.get("API_URL");
  final dio = Dio();

  Future getUserInfo() => userGetRequest("user/info");

  Future getUserInfoById(String id) => userGetRequest("user/info/$id");

  Future getPartners() => userGetRequest("get_partners");

  Future getInvitations() => userGetRequest("match/invitations");

  Future resetNotifications() => userGetRequest("user/reset-notifications");

  Future searchUser(String user) => userGetRequest("user/search/$user");

  Future<Map> addUserPartner({partner}) =>
      userPutRequest("add_partner", partner);

  Future<Map<String, dynamic>> updateUser(UpdateUser user) =>
      userPutRequest("user/update", user);

  Future<Map> updateUserPlatforms({platforms}) =>
      userPutRequest("user/update", platforms);

  Future userGetRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/$apiUrl");

      final resp = await http.get(url, headers: {"Authorization": "Bearer $token"});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"error": e, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map> userPostRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/$apiUrl");

      final resp = await http.post(url, headers: {"Authorization": "Bearer $token"}, body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"error": e, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> userPutRequest(
      String apiUrl, Object body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/$apiUrl");

      
      body = jsonEncode(body);
      final resp = await http.put(url,
          headers: {"Authorization": "Bearer $token", 'Content-Type': 'application/json'},
          body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"error": "Network error", "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> deleteUser() async {
    try {
      final String? token = await _storage.read(key: "token");

      final url = "$baseUrl/super/user";

      final response = await dio.delete(url, options: Options(headers:  {"Authorization": "Bearer $token"}));

      await _storage.deleteAll();

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
