import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/sockets_service.dart';
import '../services/local_notifications_service.dart';

/// Tipo que maneja el estado del ciclo de vida de la aplicación
/// y reinicia automáticamente el background service cuando la aplicación vuelve al primer plano
class AppLifecycleManager extends WidgetsBindingObserver {
  static final AppLifecycleManager _instance = AppLifecycleManager._internal();
  factory AppLifecycleManager() => _instance;
  AppLifecycleManager._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Timer? _serviceCheckTimer;
  bool _isInitialized = false;
  AppLifecycleState? _currentState;

  /// Inicializa el observer del ciclo de vida
  void initialize() {
    if (!_isInitialized) {
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;
      _startPeriodicServiceCheck();
      debugPrint('AppLifecycleManager initialized');
    }
  }

  /// Limpia los recursos y remueve el observer
  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
      _serviceCheckTimer?.cancel();
      _isInitialized = false;
      debugPrint('AppLifecycleManager disposed');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    debugPrint('App lifecycle state changed to: $state');
    _currentState = state;

    switch (state) {
      case AppLifecycleState.resumed:
        _onAppResumed();
        break;
      case AppLifecycleState.paused:
        _onAppPaused();
        break;
      case AppLifecycleState.inactive:
        _onAppInactive();
        break;
      case AppLifecycleState.detached:
        _onAppDetached();
        break;
      case AppLifecycleState.hidden:
        _onAppHidden();
        break;
    }
  }

  /// Maneja cuando la aplicación vuelve al primer plano
  void _onAppResumed() async {
    debugPrint('App resumed - checking background service status');
    
    try {
      // Verificar si el usuario está logueado
      final token = await _storage.read(key: "token");
      if (token == null) {
        debugPrint('No token found, user not logged in');
        return;
      }

      // Verificar si el servicio está corriendo
      final service = FlutterBackgroundService();
      final isServiceRunning = await service.isRunning();
      
      if (!isServiceRunning) {
        debugPrint('Background service not running, restarting...');
        await _restartBackgroundService();
      } else {
        debugPrint('Background service is already running');
        // Opcional: enviar un ping al servicio para verificar que esté funcionando
        _pingBackgroundService();
      }
    } catch (e) {
      debugPrint('Error checking background service on resume: $e');
      // Intentar reiniciar el servicio como fallback
      await _restartBackgroundService();
    }
  }

  /// Maneja cuando la aplicación se pausa
  void _onAppPaused() {
    debugPrint('App paused');
    // Aquí se puede realizar cualquier limpieza necesaria
  }

  /// Maneja cuando la aplicación se vuelve inactiva
  void _onAppInactive() {
    debugPrint('App inactive');
  }

  /// Maneja cuando la aplicación se desconecta
  void _onAppDetached() {
    debugPrint('App detached');
  }

  /// Maneja cuando la aplicación se oculta (nuevo en Flutter)
  void _onAppHidden() {
    debugPrint('App hidden');
  }

  /// Reinicia el background service
  Future<void> _restartBackgroundService() async {
    try {
      debugPrint('Restarting background service...');
      
      // Verificar token nuevamente antes de iniciar
      final token = await _storage.read(key: "token");
      if (token == null) {
        debugPrint('Cannot start service: no token available');
        return;
      }

      // Inicializar las notificaciones si no están inicializadas
      await LocalNotificationsService.initialize();
      
      // Pequeña pausa para asegurar que las notificaciones estén listas
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Inicializar y luego iniciar el servicio
      await initializeService();
      await Future.delayed(const Duration(milliseconds: 300));
      
      startBackgroundService();
      
      debugPrint('Background service restarted successfully');
    } catch (e) {
      debugPrint('Error restarting background service: $e');
    }
  }

  /// Envía un ping al background service para verificar que esté respondiendo
  void _pingBackgroundService() {
    try {
      final service = FlutterBackgroundService();
      service.invoke('keepAlive', {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'source': 'lifecycle_check'
      });
      debugPrint('Ping sent to background service');
    } catch (e) {
      debugPrint('Error pinging background service: $e');
    }
  }

  /// Inicia un chequeo periódico del estado del servicio
  void _startPeriodicServiceCheck() {
    _serviceCheckTimer?.cancel();
    
    // Chequear cada 2 minutos si el servicio sigue activo
    _serviceCheckTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      await _performPeriodicServiceCheck();
    });
  }

  /// Realiza un chequeo periódico del servicio
  Future<void> _performPeriodicServiceCheck() async {
    try {
      // Solo chequear si la app está en primer plano
      if (_currentState != AppLifecycleState.resumed) {
        return;
      }

      final token = await _storage.read(key: "token");
      if (token == null) return;

      final service = FlutterBackgroundService();
      final isServiceRunning = await service.isRunning();
      
      if (!isServiceRunning) {
        debugPrint('Periodic check: Background service not running, restarting...');
        await _restartBackgroundService();
      } else {
        // Enviar ping para verificar que responde
        _pingBackgroundService();
      }
    } catch (e) {
      debugPrint('Error in periodic service check: $e');
    }
  }

  /// Método público para forzar un chequeo del servicio
  Future<void> forceServiceCheck() async {
    debugPrint('Force service check requested');
    await _performPeriodicServiceCheck();
  }

  /// Método público para obtener el estado actual de la aplicación
  AppLifecycleState? get currentState => _currentState;

  /// Método público para verificar si el observer está inicializado
  bool get isInitialized => _isInitialized;
}
