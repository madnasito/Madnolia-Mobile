import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:Madnolia/global/environment.dart';

import '../models/user_model.dart';

class AuthService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();

  Future login(String username, String password) async {
    try {
      final url = Uri.parse("${Environment.apiUrl}/login");

      print(url);
      authenticating = true;
      final resp = await http.post(url,
          // headers: {"Content-Type": "application/json"},h
          body: {"username": username, "password": password});

      authenticating = false;

      final respBody = jsonDecode(resp.body);

      if (respBody["ok"]) {
        await _storage.write(key: "token", value: respBody["token"]);
        return {"ok": true};
      } else {
        return {"ok": false, "message": respBody["message"]};
      }
    } catch (e) {
      print(e);
      return {"ok": false, "message": "Error"};
    }
  }

  Future<Map<String, dynamic>> register(User user) async {
    try {
      authenticating = true;

      final url = Uri.parse("${Environment.apiUrl}/signin");

      final userJson = {
        'name': user.name,
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'platforms':
            user.platforms.map((platform) => platform.toString()).toList(),
      };
      final response = await http.post(
        url,
        body: jsonEncode(userJson),
        headers: {'Content-Type': 'application/json'},
      );

      authenticating = false;

      final respDecoded = jsonDecode(response.body);

      if (response.statusCode == 200 && respDecoded["ok"]) {
        _storage.write(key: "token", value: respDecoded["token"]);

        return {"ok": true, "user": respDecoded["userdB"]};
      } else {
        // Handle specific error codes or messages
        if (response.statusCode == 400) {
          return {"ok": false, "error": "Invalid user data"};
        } else if (response.statusCode == 401) {
          return {"ok": false, "error": "Unauthorized access"};
        } else {
          return {"ok": false, "error": "An unknown error occurred"};
        }
      }
    } catch (e) {
      // Print the exception for debugging purposes

      // Return an error response
      return {"ok": false, "error": "Network error"};
    }
  }

  Future verifyUser(String username, String email) async {
    try {
      final url =
          Uri.parse("${Environment.apiUrl}/verify_user/$username/$email");
      authenticating = true;

      final resp = await http.post(url);

      authenticating = false;

      final respBody = jsonDecode(resp.body);

      if (respBody["ok"]) {
        return {"ok": true};
      }

      return {"ok": false, "message": respBody["err"]["message"]};
    } catch (e) {
      return {"ok": false, "message": "Network error"};
    }
  }
}
