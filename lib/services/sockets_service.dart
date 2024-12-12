import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/global/environment.dart';
import 'package:madnolia/models/invitation_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/chat/message_model.dart';

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  final Socket socket = io(
    Environment.socketUrl,
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .enableReconnection()
      .disableForceNew()
      .setAuth({"token": token})
      .setExtraHeaders({"token": token})
      .build(),
  );

  String currentRoom = "";
  String username = "";

  socket.onConnect((_) async {

    print('Connected. Socket ID: ${socket.id}');

  });

  socket.on("message", (payload) async {
      print("MESSAGE!!!");
      print(username);
      print(currentRoom);
      Message message = Message.fromJson(payload);

      service.invoke("message", payload);
      

      print(message);

      // if(currentRoom != message.to && message.text.contains("@$username")){
      // }
      // Send message to UI (if app is in foreground)
      // if (window.isActive) {
      //   // Create a method to send data to the UI (e.g., using a Stream or Provider)
      //   // Example:
      //   // _messageStreamController.sink.add(message); 
      // } else {
      //   // Handle background notification for new messages
      //   // (e.g., using a notification plugin like flutter_local_notifications) 
      // }
    });

  socket.on("invitation", (data) async {
      try {
        Invitation invitation = Invitation.fromJson(data);

        // Send invitation to UI (if app is in foreground)
        // if (window.isActive) {
        //   // Create a method to send data to the UI (e.g., using a Stream or Provider)
        //   // Example:
        //   // _invitationStreamController.sink.add(invitation); 
        // } else {
        //   // Handle background notification for new invitations
        //   // (e.g., using a notification plugin like flutter_local_notifications) 
        // }
      } catch (e) {
        print(e);
      }
    });

  socket.on("match_ready", (data) async {
      print("NOW ON BACKGROUND");
      print(data);
      // Send match ready event to UI (if app is in foreground)
      // if (window.isActive) {
      //   // Create a method to send data to the UI (e.g., using a Stream or Provider)
      //   // Example:
      //   // _matchReadyStreamController.sink.add(data); 
      // } else {
      //   // Handle background notification for match ready event
      //   // (e.g., using a notification plugin like flutter_local_notifications) 
      // }
    });

  socket.onDisconnect((_) => {

  });

  service.on("update_socket").listen((event) {
    print("Update socket");
    print(event);
  });
  
  service.on("update_username").listen((onData) => username = onData?["username"]);

  service.on("stop").listen((event) {
      socket.disconnect(); // Disconnect when the service stops
      service.stopSelf();
      print("background process is now stopped");
    });

  service.on("init_chat").listen((onData) {
      socket.emit("init_chat", {onData?["room"]});
      currentRoom = onData?["room"];
    }
  );

  service.on("new_message").listen((onData) {
      socket.emit("message", onData);
      print("Enviando mensaje");}
    );

  service.on("disconnect_chat").listen((onData) {
    socket.emit("disconnect_chat");
    currentRoom = "";
  });

  service.on("off_new_player_to_match").listen((onData) => socket.emit("off_new_player_to_match"));

  service.on("join_to_match").listen((onData) => socket.emit("join_to_match", onData?["match"]));
}

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

class SocketService {
  late Socket socket;

  static void start() {
    startBackgroundService();
  }

  static void stop() {
    stopBackgroundService();
  }

  @pragma('vm:entry-point')
  static Future<bool> startOnIos(ServiceInstance service) async =>
      onIosBackground(service);
}

Future<FlutterBackgroundService> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );

  return service;
}