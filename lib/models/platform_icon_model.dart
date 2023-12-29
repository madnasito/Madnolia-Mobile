import 'package:flutter/material.dart';

class PlatformIcon {
  String path;
  bool active;
  int size;

  PlatformIcon(
      {required this.path,
      required this.active,
      required this.size,
      required MaterialColor background});
}
