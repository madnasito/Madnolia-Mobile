import 'package:flutter_secure_storage/flutter_secure_storage.dart';

logoutApp() async {
  const storage = FlutterSecureStorage();
  await storage.deleteAll();

  
}