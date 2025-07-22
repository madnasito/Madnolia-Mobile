import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/routes/routes.dart';
import 'sockets_service.dart';

class AppLifecycleService extends WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  bool _serviceStarted = false;
  AppLifecycleState? _lastState;
  Timer? _monitoringTimer;
  DateTime? _lastKeepalive;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _monitoringTimer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    _lastState = state;
    
    debugPrint('App lifecycle state changed: $state');
    
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground - safe to start background service

        if(await getToken() is String){
          if (!_serviceStarted) {
            _startServiceSafely();
          }
        }
        break;
      case AppLifecycleState.paused:
        // App is going to background - service should already be running
        debugPrint('App going to background, service status: $_serviceStarted');
        break;
      case AppLifecycleState.detached:
        // App is being terminated
        debugPrint('App detached');
        break;
      case AppLifecycleState.inactive:
        // App is inactive (e.g., incoming call)
        debugPrint('App inactive');
        break;
      case AppLifecycleState.hidden:
        // App is hidden (iOS specific)
        debugPrint('App hidden');
        break;
    }
  }

  void _startServiceSafely() {
    try {
      startBackgroundService();
      _serviceStarted = true;
      debugPrint('Background service started from lifecycle manager');
      _startServiceMonitoring();
    } catch (e) {
      debugPrint('Failed to start background service from lifecycle: $e');
    }
  }
  
  void _startServiceMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = Timer.periodic(const Duration(minutes: 2), (timer) async {
      try {
        final service = FlutterBackgroundService();
        bool isRunning = await service.isRunning();
        
        if (!isRunning && _serviceStarted) {
          debugPrint('Service died! Attempting restart...');
          _serviceStarted = false;
          if (_lastState == AppLifecycleState.resumed || _lastState == null) {
            _startServiceSafely();
          }
        } else if (isRunning) {
          // Service is alive, send keepalive
          service.invoke('keepAlive', {'from': 'monitor'});
        }
      } catch (e) {
        debugPrint('Service monitoring error: $e');
      }
    });
  }

  void startServiceIfForeground() {
    if (_lastState == AppLifecycleState.resumed || _lastState == null) {
      _startServiceSafely();
    } else {
      debugPrint('Cannot start service - app not in foreground (state: $_lastState)');
    }
  }

  bool get isServiceStarted => _serviceStarted;
}
