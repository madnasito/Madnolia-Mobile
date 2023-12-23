import 'package:flutter/foundation.dart';

class Environment {
  static String apiUrl = kDebugMode
      ? "http://192.168.0.175:3000/api"
      : "https://www.madnolia.app/api";
  static String socketUrl =
      kDebugMode ? "http://192.168.0.175:3000" : "https://madnolia.app";
}
