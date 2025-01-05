import 'package:flutter/foundation.dart';

class Environment {
  static String apiUrl = kDebugMode
      ? "http://192.168.1.3:3000/api/v1"
      : "https://madnolia.koyeb.app/api/v1";
  static String socketUrl =
      kDebugMode ? "http://192.168.1.3:3000" : "https://madnolia.koyeb.app";
}
