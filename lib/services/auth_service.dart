import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/global/environment.dart';

import '../models/user_model.dart';

class AuthService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  Future login(String username, String password) async {
    try {
      final url = Uri.parse("${Environment.apiUrl}/login");

      authenticating = true;
      final resp = await http.post(url,
          // headers: {"Content-Type": "application/json"},
          body: {"username": username, "password": password});

      authenticating = false;

      final respBody = jsonDecode(resp.body);

      if (respBody["ok"]) {
        await _storage.write(key: "token", value: respBody["token"]);
      }

      return jsonDecode(resp.body);
    } catch (e) {
      return false;
    }
  }

  Future register(User user) async {
    try {
      authenticating = true;

      final url = Uri.parse("${Environment.apiUrl}/signin");

      final resp = await http.post(url, body: {
        "name": user.name,
        "username": user.username,
        "platforms": user.platforms,
        "email": user.email,
        "password": user.password,
      });

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
    }
  }
}
