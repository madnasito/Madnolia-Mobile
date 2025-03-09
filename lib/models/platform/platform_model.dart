import 'package:flutter/material.dart';

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