// ignore: library_prefixes
import 'package:Madnolia/models/match_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../global/environment.dart';
import 'notification_service.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void connect() async {
    final token = await const FlutterSecureStorage().read(key: "token");

      _socket = IO.io(
          Environment.socketUrl,
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableAutoConnect() // disable auto-connection
              .setExtraHeaders({"x-token": token})
              .build());
    // Init socket

    _socket.onConnect((_) async {
      _serverStatus = ServerStatus.online;
      // Mueve la notificación aquí

      _socket.on("notification", (data) async {
        Match match = Match.fromJson(data["match"]);

        await NotificationService.showNotification(
            title: "Invitation to a Match",
            body: "Game name",
            notificationLayout: match.img != null
                ? NotificationLayout.BigPicture
                : NotificationLayout.Default,
            bigPicture: match.img != null ? match.img : null,
            payload: {"match": matchToJson(match)},
            actionButtons: []);
      });

      _socket.on("match_ready", (data) async {
        // Match match = Match.fromJson(data["match"]);

        await NotificationService.showNotification(
            title: "The match is ready",
            body: data["name"],
            actionButtons: [],
            payload: {"match": data["match"]});
      });
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on("message", (payload) async {
      // await NotificationService.showNotification(
      //     title: payload["user"]["username"],
      //     body: payload["text"],
      //     notificationLayout: NotificationLayout.Messaging);
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
