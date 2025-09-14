import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 13, 0, 24),
            Color.fromARGB(255, 3, 0, 25)
          ])),
      child: child,
    );
  }
}
