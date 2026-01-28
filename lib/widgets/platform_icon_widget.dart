import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';

class PlatformIcon extends StatelessWidget {
  final PlatformIconModel platform;

  const PlatformIcon({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final iconSize = (platform.size * MediaQuery.of(context).size.width) / 100;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: platform.padding),
          child: SvgPicture.asset(
            platform.path,
            height: iconSize,
            width: iconSize,
            colorFilter: (platform.active)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : const ColorFilter.mode(
                    Color.fromARGB(172, 109, 109, 109),
                    BlendMode.srcIn,
                  ),
          ),
        ),
        if (platform.active)
          Positioned(
            top: -1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: platform.padding,
                horizontal: 10,
              ),
              child: SvgPicture.asset(
                platform.path,
                height: iconSize * 1.01,
                width: iconSize * 1.01,
                colorFilter: const ColorFilter.mode(
                  Color.fromARGB(60, 255, 255, 255),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
