import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SuperCube extends StatefulWidget {
  final double size;

  const SuperCube({super.key, required this.size});

  @override
  State<SuperCube> createState() => _SuperCubeState();
}

class _SuperCubeState extends State<SuperCube>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    rotation = Tween(begin: 0.0, end: 2.0 * pi).animate(controller);

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: Stack(alignment: Alignment.center, children: [
        Cube(
          size: widget.size * 1.05,
          borderWidth: 5,
        ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Cube(
              size: widget.size,
              borderWidth: 3,
            ))
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

class Cube extends StatelessWidget {
  final double size;
  final double borderWidth;
  const Cube({super.key, required this.size, this.borderWidth = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff00bfff), Color(0xffff0066)]),
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}
