import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';

bool active = false;

class PlatformIcon extends StatefulWidget {
  final PlatformIconModel platform;

  const PlatformIcon({super.key, required this.platform});

  @override
  State<PlatformIcon> createState() => _PlatformIconState();
}

class _PlatformIconState extends State<PlatformIcon> {
  @override
  Widget build(BuildContext context) {
    final iconSize =
        (widget.platform.size * MediaQuery.of(context).size.width) / 100;
    return  Stack(
      alignment: Alignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: widget.platform.padding),
            child: SvgPicture.asset(
              widget.platform.path,
              height: iconSize,
              width: iconSize,
              colorFilter:
                (widget.platform.active) 
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(Color.fromARGB(172, 109, 109, 109), BlendMode.srcIn)
            ),
        ),
        
        if(widget.platform.active) Positioned(
          top: -1,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.platform.padding, horizontal: 10),
              child: SvgPicture.asset(
                widget.platform.path,
                height: iconSize * 1.01,
                width: iconSize * 1.01,
                colorFilter:
                  (widget.platform.active) 
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : const ColorFilter.mode(Color.fromARGB(172, 109, 109, 109), BlendMode.srcIn)
              ),
          ),),
        )
      ],
    );
  }
}
