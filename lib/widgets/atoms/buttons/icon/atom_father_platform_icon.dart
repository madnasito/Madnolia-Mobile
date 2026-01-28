import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/platform/platform_icon_model.dart';

class AtomFatherPlatformIcon extends StatelessWidget {
  final PlatformIconModel platform;
  const AtomFatherPlatformIcon({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final iconSize = (platform.size * MediaQuery.of(context).size.width) / 100;
    return Container(
      padding: const EdgeInsets.all(2),
      width: iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.black,
          width: 2,
          style: platform.active ? BorderStyle.solid : BorderStyle.none,
        ),
        color: platform.active ? platform.background : Colors.transparent,
      ),
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
    );
  }
}
