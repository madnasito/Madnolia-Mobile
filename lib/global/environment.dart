import 'package:flutter/foundation.dart';

class Environment {
  static String apiUrl = kDebugMode
      ? "http://192.168.43.219:3000/api"
      : "https://madnolia.app/api";
  static String socketUrl =
      kDebugMode ? "http://192.168.154.108:3000" : "https://madnolia.app";
}
