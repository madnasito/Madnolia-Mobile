import 'package:Madnolia/models/match/match_with_game_model.dart';
// import 'package:Madnolia/models/match/minimal_match_model.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String name;
  final String? background;
  final Widget bottom;
  const GameCard({super.key,required this.name,  required this.background, required this.bottom});

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
              background != null
                  ? FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(_resizeImage(background!)))
                  // ? Image.network(game.backgroundImage!)
                  : Image.asset("assets/no image.jpg"),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    name,
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
  final MatchWithGame match;
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
              match.game.background != null
                  ? FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(_resizeImage(match.game.background!)))
                  // ? Image.network(game.backgroundImage!)
                  : Image.asset("assets/no image.jpg"),
              // Image.network(match.img != null ? match.img.toString() : ""),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    match.game.name,
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

String _resizeImage(String url) {
    List image = url.split("/");
    if (image[image.length - 3] == "screenshots") {
      return "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
    } else {
      return "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
    }
  
}
