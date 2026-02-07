import 'dart:convert';
import 'package:dio/dio.dart'
    show Dio, DioException, FormData, MultipartFile, Options, Response;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/models/user/update_profile_picture_response.dart';
import 'package:madnolia/models/user/update_user_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class UserService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.get("API_URL");
  final Dio dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printErrorData: true,
          printErrorMessage: true,
          printResponseData: false,
          printResponseMessage: false,
          printRequestData: false,
        ),
      ),
    );

  Future<User> getUserInfo() async {
    try {
      Response response;

      final String? token = await _storage.read(key: "token");

      response = await dio.get(
        '$baseUrl/user/info',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return User.fromJson(response.data);
    } catch (e) {
      debugPrint('Error getting user info ${e.toString()}');
      rethrow;
    }
  }

  Future<SimpleUser> getUserInfoById(String id) async {
    try {
      Response response;

      final String? token = await _storage.read(key: "token");

      debugPrint('Getting user info: $id');

      response = await dio.get(
        '$baseUrl/user/info/$id',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return SimpleUser.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SimpleUser>> getUsersInfoByIds(List<String> ids) async {
    try {
      Response response;

      final String? token = await _storage.read(key: "token");

      debugPrint('Getting info of users: $ids');

      response = await dio.post(
        '$baseUrl/user/info/multiple',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {'ids': ids},
      );

      List<SimpleUser> users = (response.data as List)
          .map((user) => SimpleUser.fromJson(user))
          .toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }

  Future getPartners() => userGetRequest("get_partners");

  Future getInvitations() => userGetRequest("match/invitations");

  Future resetNotifications() => userGetRequest("user/reset-notifications");

  Future searchUser(String user) =>
      userGetRequest("user/search-to-invite/$user");

  Future<Map> addUserPartner({required String partner}) =>
      userPutRequest("add_partner", partner);

  Future<User> updateUser(UpdateUser user) async {
    try {
      Response response;

      final String? token = await _storage.read(key: "token");

      response = await dio.put(
        '$baseUrl/user/update',
        data: user.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final userUpdated = User.fromJson(response.data);

      return userUpdated;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data is Map) {
          throw e.response?.data;
        } else {
          throw {'message': 'NETWORK_ERROR'};
        }
      } else {
        throw {'message': 'NETWORK_ERROR'};
      }
    }
  }

  Future<UpdateProfilePictureResponse> updateProfilePicture(
    String path,
    Function(int) updatePercentage,
  ) async {
    try {
      Response response;

      final String? token = await _storage.read(key: "token");

      final data = FormData.fromMap({
        'image': await MultipartFile.fromFile(path),
      });

      response = await dio.post(
        "$baseUrl/user/update-img",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        onSendProgress: (int sent, int total) {
          final percentage = (sent / total * 100).round();
          updatePercentage(percentage);
          debugPrint('${sent / 1024} ${total / 1024}');
        },
      );

      return UpdateProfilePictureResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUserPlatforms({
    required Map<String, dynamic> platforms,
  }) => userPutRequest("user/update", platforms);

  Future userGetRequest(String apiUrl) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/$apiUrl");

      final resp = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

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

      final resp = await http.post(
        url,
        headers: {"Authorization": "Bearer $token"},
        body: body,
      );

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"error": e, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> userPutRequest(
    String apiUrl,
    Object body,
  ) async {
    try {
      authenticating = true;
      final String? token = await _storage.read(key: "token");
      final url = Uri.parse("$baseUrl/$apiUrl");

      body = jsonEncode(body);
      final resp = await http.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: body,
      );

      authenticating = false;

      return jsonDecode(resp.body);
    } catch (e) {
      // print(e);
      return {"error": "Network error", "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> deleteUser(String password) async {
    try {
      final String? token = await _storage.read(key: "token");

      final url = "$baseUrl/super/user";

      final response = await dio.delete(
        url,
        data: {'password': password},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserInfoByExternalToken({required String token}) async {
    try {
      final url = "$baseUrl/user/info";

      final response = await dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
