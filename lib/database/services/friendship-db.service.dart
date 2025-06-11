import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/database/providers/friendship_db.dart';
class FriendshipService {
  
  final dio = Dio();
  final _storage = const FlutterSecureStorage();

  final String baseUrl = dotenv.get("API_URL");


  Future<FriendshipDb> getFriendshipByUserApi(String user) async {
    try {

      final url = "$baseUrl/friendship/with";
      final String? token = await _storage.read(key: "token");

      final resp = await dio.get(url, queryParameters: {'user': user}, options: Options(headers: {"Authorization": "Bearer $token"}));
      
      return FriendshipDb.fromJson(resp.data);

      // final response()
    } catch (e) {
      rethrow;
    }
  }

  Future<FriendshipDb> getFriendshipByIdApi(String id) async {
    try {

      final url = "$baseUrl/friendship/get";
      final String? token = await _storage.read(key: "token");

      final resp = await dio.get(url, queryParameters: {'id': id}, options: Options(headers: {"Authorization": "Bearer $token"}));

      final friendship = FriendshipDb.fromMap(resp.data);
      
      return friendship;

      // final response()
    } catch (e) {
      rethrow;
    }
  }

  Future<FriendshipDb> getFriendship(String id) async{

    try {
      
      final existingFriendship  = await FriendshipProvider.getFriendship(id);
      final now = DateTime.now();

      if(existingFriendship != null && now.difference(existingFriendship.lastUpdated).inHours < 1) {
        return existingFriendship;
      }

      if(existingFriendship == null){
        return await getFriendshipByIdApi(id);
      }

      return existingFriendship;
    } catch (e) {
      rethrow;
    }

  }
}
