import 'package:flutter/material.dart';

class GameImageAtom extends StatelessWidget {
  final String name;
  final String? background;
  const GameImageAtom({super.key, required this.name, this.background});

  @override
  Widget build(BuildContext context) {
    return Stack(
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