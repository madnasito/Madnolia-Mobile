import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AtomGameImage extends StatelessWidget {
  final String name;
  final String? background;
  const AtomGameImage({super.key, this.name = '', this.background});

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              background == null || background == ""
                  ? Image.asset("assets/no image.jpg")
                  // ? Image.network(game.backgroundImage!)
                  : FadeInImage(
                    placeholderFit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: CachedNetworkImageProvider(resizeImage(background!)), fit: BoxFit.cover,),
              name != '' ?
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    name,
                    style: const TextStyle(
                        backgroundColor: Colors.black54, fontSize: 15),
                  )
                ) : SizedBox()
            ],
          );
  }
}

String resizeImage(String url) {
    List image = url.split("/");
    if (image[image.length - 3] == "screenshots") {
      return "https://media.rawg.io/media/crop/600/400/screenshots/${image[image.length - 2]}/${image[image.length - 1]}";
    } else {
      return "https://media.rawg.io/media/crop/600/400/games/${image[image.length - 2]}/${image[image.length - 1]}";
    }
}