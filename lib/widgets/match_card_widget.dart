import 'package:flutter/material.dart';

import '../models/game_model.dart';

import 'package:Madnolia/models/match_model.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final Widget bottom;
  const GameCard({super.key, required this.game, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          Stack(
            children: [
              game.backgroundImage != null
                  ? FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(_resizeImage(game.backgroundImage)))
                  // ? Image.network(game.backgroundImage!)
                  : Image.asset("assets/no image.jpg"),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    game.name,
                    style: const TextStyle(
                        backgroundColor: Colors.black54, fontSize: 15),
                  ))
            ],
          ),
          bottom
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final Match match;
  final Widget bottom;
  const MatchCard({super.key, required this.match, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          Stack(
            children: [
              match.img != null
                  ? FadeInImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(match.img!))
                  // ? Image.network(game.backgroundImage!)
                  : Image.asset("assets/no image.jpg"),
              // Image.network(match.img != null ? match.img.toString() : ""),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    match.gameName,
                    style: const TextStyle(
                        backgroundColor: Colors.black54, fontSize: 15),
                  ))
            ],
          ),
          bottom
        ],
      ),
    );
  }
}

_resizeImage(String? url) {
  if (url != null) {
    List image = url.split("/");
    if (image[image.length - 3] == "screenshots") {
      return "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
    } else {
      return "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
    }
  } else {
    return null;
  }
}
