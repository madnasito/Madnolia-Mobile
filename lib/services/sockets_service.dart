import 'package:Madnolia/main.dart';
import 'package:Madnolia/models/invitation_model.dart';
import 'package:Madnolia/models/message_model.dart';
import 'package:Madnolia/providers/user_provider.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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

    final userProvider = Provider.of<UserProvider>(
        MyApp.navigatorKey.currentContext!,
        listen: false);

    _socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .disableForceNew()
            .disableMultiplex()
            .setExtraHeaders({"x-token": token})
            .build());
    // Init socket

    _socket.onConnect((_) async {
      print("conected");
      _serverStatus = ServerStatus.online;

      _socket.on("message", (payload) async {
        Message message = Message.fromJson(payload);

        final List<String> wordsList = message.text.split(" ");

        List<String> mentions = wordsList
            .where((element) => element == "@${userProvider.user.username}")
            .toList();

        if (mentions.isNotEmpty) {
          print("Crea notification");
          await NotificationService.showNotification(
              title: message.user.name,
              body: message.text,
              largeIcon: message.user.thumbImg,
              summary: message.user.name,
              notificationLayout: NotificationLayout.Messaging,
              actionButtons: [
                NotificationActionButton(
                    key: "reply",
                    label: "Reply",
                    autoDismissible: true,
                    requireInputText: true,
                    actionType: ActionType.SilentAction),
              ],
              payload: {
                "match": message.room
              });
        }
      });

      _socket.on("notification", (data) async {
        // Match match = Match.fromJson(data["match"]);
        Invitation match = Invitation.fromJson(data);

        await NotificationService.showNotification(
            title: "Invitation to a Match",
            body: "Game name",
            // ignore: unnecessary_null_comparison
            notificationLayout: match.img != null
                ? NotificationLayout.BigPicture
                : NotificationLayout.Default,
            // ignore: unnecessary_null_comparison
            bigPicture: match.img != null ? match.img : null,
            payload: {
              "match": match.match
            },
            actionButtons: [
              NotificationActionButton(
                  key: "accept",
                  label: "Accept",
                  color: Colors.blue,
                  actionType: ActionType.DismissAction,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "decline",
                  label: "Decline",
                  actionType: ActionType.SilentAction,
                  color: Colors.blueGrey)
            ]);
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
  }

  void disconnect() {
    _socket.disconnect();
  }
}
