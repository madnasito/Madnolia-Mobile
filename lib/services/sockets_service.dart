// ignore: library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../global/environment.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void connect() async {
    final token = await const FlutterSecureStorage().read(key: "token");
    // Init socket
    _socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .setExtraHeaders({"x-token": token})
            .enableForceNew()
            .build());

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      // Mueve la notificación aquí
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on("nuevo-mensaje", (payload) {
      print("nuevo mensaje: $payload");
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
