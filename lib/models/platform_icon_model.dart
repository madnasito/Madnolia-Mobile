import 'package:flutter/material.dart';

class PlatformIconInfo {
  String path;
  bool active;
  int size;

  PlatformIconInfo(
      {required this.path,
      required this.active,
      required this.size,
      required MaterialColor background});
}
