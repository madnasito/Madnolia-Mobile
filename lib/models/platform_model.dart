import 'package:flutter/material.dart';

class Platform {
  String path;
  bool active;
  int size;

  Platform(
      {required this.path,
      required this.active,
      required this.size,
      required MaterialColor background});
}
