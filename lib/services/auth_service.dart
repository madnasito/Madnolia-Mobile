import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/models/auth/register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:madnolia/types/app_lifecycle_state.dart';

class AuthService {
  bool authenticating = false;

  final _storage = const FlutterSecureStorage();
  final String apiUrl = dotenv.get("API_URL");
  final _dio = Dio();

  Future login(String username, String password) async {
    try {
      final url = Uri.parse("$apiUrl/auth/sign-in");

      authenticating = true;
      final resp = await http.post(url,
          body: {"username": username, "password": password});

      authenticating = false;

      Map respBody = jsonDecode(resp.body);

      if (respBody.containsKey("token")) {
        // IMPORTANTE: Guardar el token PRIMERO antes de iniciar el servicio
        await _storage.write(key: "token", value: respBody["token"]);
        await _storage.write(key: "userId", value: respBody["user"]["_id"]);
        
        // Esperar un momento para asegurar que el token esté guardado
        await Future.delayed(const Duration(milliseconds: 300));
        
        // Inicializar y iniciar el servicio
        await _initializeAndStartService();
        
        // Forzar una verificación inmediata del lifecycle manager
        await AppLifecycleManager().forceServiceCheck();
        
        return respBody;
      } else {
        return respBody;
      }
    } catch (e) {
      debugPrint(e.toString());
      return {"error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> register(RegisterModel user) async {
    try {
      authenticating = true;

      final url = Uri.parse("$apiUrl/auth/sign-up");

      final userJson = {
        'name': user.name,
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'platforms':
            user.platforms.map((platform) => platform).toList(),
      };
      final response = await http.post(
        url,
        body: jsonEncode(userJson),
        headers: {'Content-Type': 'application/json'},
      );

      authenticating = false;

      final Map<String,dynamic> respDecoded = jsonDecode(response.body);

      if (respDecoded.containsKey("user")) {
        // IMPORTANTE: Guardar el token PRIMERO antes de iniciar el servicio
        await _storage.write(key: "token", value: respDecoded["token"]);
        await _storage.write(key: "userId", value: respDecoded["user"]["_id"]);
        
        // Esperar un momento para asegurar que el token esté guardado
        await Future.delayed(const Duration(milliseconds: 300));
        
        // Inicializar y iniciar el servicio
        await _initializeAndStartService();
        
        // Forzar una verificación inmediata del lifecycle manager
        await AppLifecycleManager().forceServiceCheck();
      }
      return respDecoded;
    } catch (e) {
      // Print the exception for debugging purposes

      // Return an error response
      return {"Error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<void> _initializeAndStartService() async {
    try {
      
      // Verificar que el token realmente exista
      final token = await _storage.read(key: "token");
      if (token == null) {
        debugPrint('No se puede iniciar servicio: token no encontrado');
        return;
      }
      
      debugPrint('Iniciando servicio con token disponible');
      
      // Inicializar canales de notificación primero y esperar
      await LocalNotificationsService.initialize();
      
      // Inicializar el servicio
      await initializeService();
      debugPrint('Servicio configurado');
      
      
      // Iniciar el servicio directamente
      startBackgroundService();
      
      debugPrint('Servicio iniciado automáticamente con token');
    } catch (e) {
      debugPrint('Error al inicializar servicio: $e');
    }
  }

  Future verifyUser(String username, String email) async {
    try {
      final url =
        Uri.parse("$apiUrl/user/user-exists/$username/$email");
        authenticating = true;

      final resp = await http.get(url);

      authenticating = false;

      final Map respBody = jsonDecode(resp.body);

      if (respBody.containsKey("error")) {
        return respBody;
      }

      return {};
    } catch (e) {
      return {"Error": true, "message": "NETWORK_ERROR"};
    }
  }

  Future<Map<String, dynamic>> updatePassword({required String token, required Map<String, String> body }) async {
    try {
      final url = "$apiUrl/auth/update-password";
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      final Map<String, dynamic> respBody = response.data;
      return respBody;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
