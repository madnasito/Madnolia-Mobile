import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'sockets_service.dart';

class AppLifecycleService extends WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  bool _serviceStarted = false;
  AppLifecycleState? _lastState;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _lastState = state;
    
    debugPrint('App lifecycle state changed: $state');
    
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground - safe to start background service
        if (!_serviceStarted) {
          _startServiceSafely();
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
    } catch (e) {
      debugPrint('Failed to start background service from lifecycle: $e');
    }
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
