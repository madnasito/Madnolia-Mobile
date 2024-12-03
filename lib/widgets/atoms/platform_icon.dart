import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/models/platform_icon_model.dart';

class PlatformButton extends StatelessWidget {
  final PlatformIconInfo platformIcon;
  final void Function()? onTap;
  const PlatformButton({this.onTap, super.key, required this.platformIcon});

  @override
  Widget build(BuildContext context) {
    final iconSize = (platformIcon.size * MediaQuery.of(context).size.width) / 100;
    return FadeIn(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SvgPicture.asset(
            platformIcon.path,
            height: iconSize,
            width: iconSize,
            colorFilter: ColorFilter.mode((platformIcon.active) ? Colors.white : const Color.fromARGB(172, 109, 109, 109), BlendMode.color)
          ),
          ),
      )
      );
  }
}