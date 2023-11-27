import 'package:flutter/src/material/colors.dart';

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
