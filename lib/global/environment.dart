import 'package:flutter/foundation.dart';

class Environment {
  static String apiUrl = kDebugMode
      ? "http://192.168.1.4:3000/api"
      : "https://madnolia.koyeb.app/api";
  static String socketUrl =
      kDebugMode ? "http://192.168.1.4:3000" : "https://madnolia.koyeb.app";
}
