
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/images_util.dart' show resizeRawgImage;

class AtomGameImage extends StatelessWidget {
  final String name;
  final String? background;
  final double borderRadius;
  final Widget? child;

  const AtomGameImage({
    super.key,
    this.name = '',
    this.background,
    this.borderRadius = 12.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          background == null || background == ""
              ? Image.asset("assets/no image.jpg", fit: BoxFit.cover)
              : FadeInImage(
                  placeholderFit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: CachedNetworkImageProvider(resizeRawgImage(background!)),
                  fit: BoxFit.cover,
                ),
          if (name != '')
            Positioned(
              bottom: 2,
              left: 2,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          if (child != null)
            Positioned(
              top: 8,
              left: 8,
              child: child!,
            ),
        ],
      ),
    );
  }
}