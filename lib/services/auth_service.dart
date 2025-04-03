import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/models/auth/register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();
  final String apiUrl = dotenv.get("API_URL");

  Future login(String username, String password) async {
    try {
      final url = Uri.parse("$apiUrl/auth/sign-in");
      print(url);

      authenticating = true;
      final resp = await http.post(url,
          // headers: {"Content-Type": "application/json"},h
          body: {"username": username, "password": password});

      authenticating = false;

      Map respBody = jsonDecode(resp.body);
      

      if (respBody.containsKey("token")) {
        await _storage.write(key: "token", value: respBody["token"]);
        return respBody;
      } else {
        return respBody;
      }
    } catch (e) {
      debugPrint(e.toString());
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> register(RegisterModel user) async {
    try {
      authenticating = true;

      final url = Uri.parse("$apiUrl/auth/sign-up");

      final userJson = {
        'name': user.name,
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'platforms':
            user.platforms.map((platform) => platform).toList(),
      };
      final response = await http.post(
        url,
        body: jsonEncode(userJson),
        headers: {'Content-Type': 'application/json'},
      );

      authenticating = false;

      final Map<String,dynamic> respDecoded = jsonDecode(response.body);

      if (respDecoded.containsKey("user")) {
        _storage.write(key: "token", value: respDecoded["token"]);
      } 
      return respDecoded;
    } catch (e) {
      // Print the exception for debugging purposes

      // Return an error response
      return {"Error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future verifyUser(String username, String email) async {
    try {
      final url =
        Uri.parse("$apiUrl/user/user-exists/$username/$email");
        authenticating = true;

      final resp = await http.get(url);

      authenticating = false;

      final Map respBody = jsonDecode(resp.body);

      if (respBody.containsKey("error")) {
        return respBody;
      }

      return {};
    } catch (e) {
      return {"Error": true, "message": "NETWORK_ERROR"};
    }
  }
}
