import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../models/tiny_rawg_game_model.dart';
import '../utils/images_util.dart' show resizeRawgImage;

class RawgService {
  static const String urlBase = "https://api.rawg.io/api";
  static final String apiKey = dotenv.get("RAWG_API_KEY");

  final Dio _dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printErrorData: true,
          printErrorMessage: true,
        ),
      ),
    );

  // Future searchGame({required String game, required String platform}) async {
  //   try {
  //     Uri url = Uri.parse("$urlBase/games");

  //     url = url.replace(queryParameters: {
  //       "key": apiKey,
  //       "search": game,
  //       "platforms": platform,
  //       "page_size": "6"
  //     });

  //     final resp = await http.get(url);

  //     final respBody = jsonDecode(resp.body);

  //     List<Game> games = [];

  //     if (respBody["results"].length > 0) {
  //       for (var game in respBody["results"]) {
  //         Game newGame = Game.fromJson(game);
  //         if (newGame.backgroundImage != null) {
  //           List image = newGame.backgroundImage!.split("/");
  //           if (image[image.length - 3] == "screenshots") {
  //             newGame.backgroundImage =
  //                 "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
  //           } else {
  //             newGame.backgroundImage =
  //                 "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
  //           }
  //         }
  //         games.add(newGame);
  //       }

  //       return games;
  //     }

  //     return respBody["results"];
  //   } catch (e) {
  //     return {"ok": false};
  //   }
  // }

  Future<List<TinyRawgGame>> searchGames({
    required String game,
    required String platform,
  }) async {
    try {
      final url = "$urlBase/games";

      Response response = await _dio.get(
        url,
        queryParameters: {
          "key": apiKey,
          "search": game,
          "platforms": platform,
          "page_size": "6",
        },
      );

      final Map<String, dynamic> responseData = response.data;

      List<TinyRawgGame> games = [];

      if (responseData['results'].length > 0) {
        games = (responseData['results'] as List)
            .map<TinyRawgGame>((gameData) => TinyRawgGame.fromJson(gameData))
            .toList();

        for (var g in games) {
          if (g.backgroundImage != null) {
            g.backgroundImage = resizeRawgImage(g.backgroundImage!);
          }
        }
      }

      return games;
    } catch (e) {
      debugPrint('Error in RawgService.searchGame: $e');
      rethrow;
    }
  }

  Future getPlatformGames({required String id}) async {
    try {
      Uri url = Uri.parse("$urlBase/games");

      url = url.replace(
        queryParameters: {
          "key": apiKey,
          "platforms": id,
          "page_size": "6",
          "tags": "online",
        },
      );

      final resp = await http.get(url);

      final respBody = jsonDecode(resp.body);

      List<TinyRawgGame> games = [];

      if (respBody["results"].length > 0) {
        for (var game in respBody["results"]) {
          TinyRawgGame newGame = TinyRawgGame.fromJson(game);
          if (newGame.backgroundImage != null) {
            List image = newGame.backgroundImage!.split("/");
            if (image[image.length - 3] == "screenshots") {
              newGame.backgroundImage =
                  "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
            } else {
              newGame.backgroundImage =
                  "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
            }
          }
          games.add(newGame);
        }

        return games;
      }

      return respBody["results"];
    } catch (e) {
      return {"ok": false};
    }
  }
}
