import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

bool active = false;

class PlatformIcon extends StatefulWidget {
  final Platform platform;

  const PlatformIcon({super.key, required this.platform});

  @override
  State<PlatformIcon> createState() => _PlatformIconState();
}

class _PlatformIconState extends State<PlatformIcon> {
  @override
  Widget build(BuildContext context) {
    final iconSize =
        (widget.platform.size * MediaQuery.of(context).size.width) / 100;
    return  Padding(
        padding: EdgeInsets.symmetric(vertical: widget.platform.padding),
        child: SvgPicture.asset(
          widget.platform.path,
          height: iconSize,
          width: iconSize,
          // ignore: deprecated_member_use
          color: (widget.platform.active)
              ? Colors.white
              : const Color.fromARGB(172, 109, 109, 109),
        ),
    );
  }
}

class Platform {
  int id;
  String path;
  bool active;
  int size;
  double padding;
  Color background = Colors.white;

  Platform(
      {required this.id,
      required this.path,
      required this.active,
      required this.size,
      this.background = Colors.white,
      this.padding = 0});
}
