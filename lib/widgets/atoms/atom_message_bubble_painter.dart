import 'package:flutter/material.dart';

class AtomMessageBubblePainter extends CustomPainter {
  final BuildContext context;
  final bool isMyMessage;

  AtomMessageBubblePainter({required this.context, required this.isMyMessage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isMyMessage ? Theme.of(context).primaryColor : Colors.grey[800]!
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isMyMessage) {
      path.moveTo(size.width - 20, size.height - 10);
      path.quadraticBezierTo(size.width, size.height - 10, size.width, size.height - 20);
      path.lineTo(size.width, 10);
      path.quadraticBezierTo(size.width, 0, size.width - 10, 0);
      path.lineTo(10, 0);
      path.quadraticBezierTo(0, 0, 0, 10);
      path.lineTo(0, size.height - 10);
      path.quadraticBezierTo(0, size.height, 10, size.height);
      path.lineTo(size.width - 20, size.height);
      path.quadraticBezierTo(size.width - 15, size.height, size.width - 20, size.height - 10);
    } else {
      path.moveTo(20, size.height - 10);
      path.quadraticBezierTo(0, size.height - 10, 0, size.height - 20);
      path.lineTo(0, 10);
      path.quadraticBezierTo(0, 0, 10, 0);
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(size.width, size.height, size.width - 10, size.height);
      path.lineTo(20, size.height);
      path.quadraticBezierTo(15, size.height, 20, size.height - 10);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
