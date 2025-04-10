import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedLogoAtom extends StatefulWidget {
  final double size;

  const AnimatedLogoAtom({super.key, required this.size});

  @override
  State<AnimatedLogoAtom> createState() => _AnimatedLogoAtomState();
}

class _AnimatedLogoAtomState extends State<AnimatedLogoAtom>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();
    if(mounted){
      controller =
          AnimationController(vsync: this, duration: const Duration(seconds: 60));

      rotation = Tween(begin: 0.0, end: 2.0 * pi).animate(controller);

      controller.addListener(() {
        if (controller.status == AnimationStatus.completed) {
          controller.repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: Stack(alignment: Alignment.center, children: [
        Image.asset("assets/madnolia-home-logo.png", width: 155),
        // Cube(
        //   size: widget.size * 1.05,
        //   borderWidth: 5,
        // ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SvgPicture.asset("assets/madnolia-logo.svg", width: 150)
            )
      ]),
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return Transform.rotate(
          angle: rotation.value,
          child: child,
        );
      },
    );
  }
}

