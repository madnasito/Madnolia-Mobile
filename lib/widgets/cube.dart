import 'package:flutter/material.dart';

class CubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    Path frontFace = Path()
      ..moveTo(50, 50)
      ..lineTo(30, 30)
      ..lineTo(30, 130)
      ..lineTo(50, 150)
      ..close();

    paint.color = Colors.blue;

    canvas.drawPath(frontFace, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}

class MyCube extends StatelessWidget {
  const MyCube({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
