import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:madnolia/global/environment.dart';

import '../models/user_model.dart';

class UserService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  Future<Map> getUserInfo() => userGetRequest("user_info");

  Future<Map> getUserMatches() => userGetRequest("player_matches");

  Future<Map> getPartners() => userGetRequest("get_partners");

  Future<Map> getInvitations() => userGetRequest("invitations");

  Future<Map> resetNotifications() => userGetRequest("reset_notifications");

  Future<Map> addUserPartner({partner}) =>
      userPutRequest("add_partner", partner);

  Future<Map<String, dynamic>> updateUser(User user) =>
      userPutRequest("update_user", user);

  Future<Map> updateUserPlatforms({platforms}) =>
      userPutRequest("update_user_platforms", platforms);

  Future<Map> userGetRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http.get(url, headers: {"token": token!});

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      authenticating = false;
      // print(e);
      return {"ok": false};
    }
  }

  Future<Map> userPostRequest(String apiUrl, Map body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http.post(url, headers: {"token": token!}, body: body);

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"ok": false};
    }
  }

  Future<Map<String, dynamic>> userPutRequest(
      String apiUrl, Object body) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("${Environment.apiUrl}/$apiUrl");

      final resp = await http.put(url,
          headers: {"token": token!, 'Content-Type': 'application/json'},
          body: jsonEncode(body));

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"ok": false};
    }
  }
}
