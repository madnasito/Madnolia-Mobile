
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AtomGameImage extends StatelessWidget {
  final String name;
  final String? background;
  final double borderRadius; // Nuevo parámetro para personalizar el radio

  const AtomGameImage({
    super.key, 
    this.name = '', 
    this.background,
    this.borderRadius = 12.0, // Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // Aplicamos bordes redondeados
      child: Stack(
        children: [
          background == null || background == ""
              ? Image.asset("assets/no image.jpg", fit: BoxFit.cover)
              : FadeInImage(
                  placeholderFit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: CachedNetworkImageProvider(resizeImage(background!)), 
                  fit: BoxFit.cover,
                ),
          name != '' 
              ? Positioned(
                  bottom: 2,
                  left: 2,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      name,
                      style: const TextStyle (
                        fontSize: 15,
                      ),
                    ),
                  ),
                ) 
              : const SizedBox(),
        ],
      ),
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