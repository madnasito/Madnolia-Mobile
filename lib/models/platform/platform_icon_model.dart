import 'package:flutter/material.dart' show Colors, Color;

class PlatformIconModel {
  int id;
  String path;
  bool active;
  int size;
  double padding;
  Color background = Colors.white;

  PlatformIconModel({
    required this.id,
    required this.path,
    required this.active,
    required this.size,
    this.background = Colors.white,
    this.padding = 0,
  });

  PlatformIconModel copyWith({
    int? id,
    String? path,
    bool? active,
    int? size,
    double? padding,
    Color? background,
  }) {
    return PlatformIconModel(
      id: id ?? this.id,
      path: path ?? this.path,
      active: active ?? this.active,
      size: size ?? this.size,
      padding: padding ?? this.padding,
      background: background ?? this.background,
    );
  }
}
