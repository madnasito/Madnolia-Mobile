import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/game_model.dart';

class RawgService {
  static const String urlBase = "https://api.rawg.io/api";
  static const String apiKey = "8af7cb7fc9d949acac94ab83be57ed1b";

  Future searchGame({required String game, required String platform}) async {
    try {
      Uri url = Uri.parse("$urlBase/games");

      url = url.replace(queryParameters: {
        "key": apiKey,
        "search": game,
        "platforms": platform,
        "page_size": "6"
      });

      final resp = await http.get(url);

      final respBody = jsonDecode(resp.body);

      List<Game> games = [];

      if (respBody["results"].length > 0) {
        for (var game in respBody["results"]) {
          Game newGame = Game.fromJson(game);
          List image = newGame.backgroundImage.split("/");
          if (image[image.length - 3] == "screenshots") {
            newGame.backgroundImage =
                "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
          } else {
            newGame.backgroundImage =
                "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
          }
          games.add(newGame);
        }

        return games;
      }

      return respBody["results"];
    } catch (e) {}
  }
}
