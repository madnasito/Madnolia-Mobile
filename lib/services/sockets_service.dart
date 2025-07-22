import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/invitation_model.dart' show Invitation;


@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  // Service will be configured as foreground through AndroidConfiguration
  debugPrint('Background service starting with foreground mode enabled');

  (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod") ;
  
  final String socketsUrl = dotenv.get("SOCKETS_URL");

  final Socket socket = io(
    socketsUrl,
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
  String? userId = await storage.read(key: "userId");
  
  // Setup periodic keepalive to prevent service termination
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    try {
      service.invoke('keepAlive', {'timestamp': DateTime.now().millisecondsSinceEpoch});
      final activeNotifications = await LocalNotificationsService.getActiveNotifications('madnolia_background');
      if(activeNotifications.isNotEmpty) LocalNotificationsService.deleteNotification(activeNotifications[0].id!);
      debugPrint('Service keepalive: ${DateTime.now()}');
    } catch (e) {
      debugPrint('Keepalive error: $e');
    }
  });

  socket.onConnect((_) async {

    debugPrint('Connected. Socket ID: ${socket.id}');

    service.invoke("connected_socket");

  });

  socket.on("added_to_match", (payload) => service.invoke("added_to_match", {"resp" : payload}));

  socket.on("message", (payload) async {

    try {
      debugPrint("MESSAGE!!!");
      debugPrint(username);
      debugPrint(currentRoom);
      service.invoke("message", payload);

      ChatMessage message = ChatMessage.fromJson(payload);

      if(message.creator == userId) return LocalNotificationsService.deleteRoomMessages(message.conversation);

      if(currentRoom != payload["conversation"] ){
        LocalNotificationsService.displayRoomMessage(message);
      }
      
    } catch (e) {
      debugPrint(e.toString());
    }
    });
  
  socket.on("update_recipient_status", (data) => service.invoke("update_recipient_status", data));

  socket.on("invitation", (data) async {
      try {
        service.invoke("invitation", data);
        Invitation invitation = Invitation.fromJson(data);
        
        LocalNotificationsService.displayInvitation(invitation);
      } catch (e) {
        debugPrint(e.toString());
      }
    });

  socket.on("match_ready", (data) async {
      debugPrint("NOW ON BACKGROUND");
      debugPrint(data.toString());
      
      LocalNotificationsService.matchReady(data);
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

  // Events to handle P2P call
  socket.on("new_call", (data) => service.invoke("new_call", data));
  socket.on("call_answered", (data) => service.invoke("call_answered", data));
  socket.on("ice_candidate", (data) => service.invoke("ice_candidate", data));
  socket.on("new_room_call", (data) => service.invoke("new_room_call", data));
  socket.on("new_call", (data) => service.invoke("new_call", data));
  socket.on("room_call_answered", (data) => service.invoke("room_call_answered", data));
  socket.on("room_ice_candidate", (data) => service.invoke("room_ice_candidate", data));

  // Events for handle user connections
  socket.on("new_request_connection", (data) => service.invoke("new_request_connection", data));
  socket.on("connection_accepted", (data) => service.invoke("connection_accepted"));
  socket.on("removed_partner", (data) => service.invoke("removed_partner"));
  socket.on("connection_rejected", (data) => service.invoke("connection_rejected"));
  socket.on("canceled_connection", (data) => service.invoke("canceled_connection"));

  socket.onDisconnect((_) => {
   service.invoke("disconnected_socket")
  });

  service.on("update_socket").listen((event) {
    debugPrint("Update socket");
    debugPrint(event.toString());
  });
  
  service.on("update_username").listen((onData) => username = onData?["username"]);

  service.on("stop").listen((event) {
      socket.disconnect(); // Disconnect when the service stops
      service.stopSelf();
      debugPrint("background process is now stopped");
    });

  service.on("init_chat").listen((onData) {
      socket.emit("init_chat", {onData?["room"]});
      currentRoom = onData?["room"];
      debugPrint("INIT CHAT: ${onData?["room"]}");
      LocalNotificationsService.deleteRoomMessages(onData?["room"]);
    }
  );

  service.on("join_room").listen((onData) {
      currentRoom = onData?["room"];
      debugPrint("INIT CHAT: ${onData?["room"]}");
      LocalNotificationsService.deleteRoomMessages(onData?["room"]);
    }
  );

  service.on("new_message").listen((onData) => socket.emit("message", onData));

  service.on("update_recipient_status").listen((onData) => socket.emit("update_recipient_status", onData));

  service.on("disconnect_chat").listen((onData) {
    socket.emit("disconnect_chat");
    currentRoom = "";
  });

  service.on("leave_room").listen((onData) {
    currentRoom = "";
  });

  service.on("off_new_player_to_match").listen((onData) => socket.emit("off_new_player_to_match"));

  service.on("join_to_match").listen((onData) => socket.emit("join_to_match", onData?["match"]));

  service.on("make_call").listen((onData) => socket.emit("make_call", onData));

  service.on("answer_call").listen((onData) => socket.emit("answer_call", onData));

  service.on("ice_candidate").listen((onData) => socket.emit("ice_candidate", onData));

  service.on("join_call_room").listen((onData) => socket.emit("join_call_room", onData));

  service.on("leave_call_room").listen((onData) => socket.emit("leave_call_room", onData));

  service.on("make_room_call").listen((onData) => socket.emit("make_room_call", onData));

  service.on("answer_room_call").listen((onData) => socket.emit("answer_room_call", onData));

  service.on("room_ice_candidate").listen((onData) => socket.emit("room_ice_candidate", onData));

  service.on("delete_chat_notifications").listen((onData) => LocalNotificationsService.deleteRoomMessages(onData?["room"]));

  service.on("delete_all_notifications").listen((onData)=> LocalNotificationsService.deleteAllNotifications());

  // Events for handle connections
  service.on('request_connection').listen((onData) => socket.emit('request_connection', onData?['user']));
  service.on('accept_connection').listen((onData) => socket.emit('accept_connection', onData?['user']));
  service.on('reject_connection').listen((onData) => socket.emit('reject_connection', onData?['user']));

}

void startBackgroundService() {
  try {  
    final service = FlutterBackgroundService();
    
    // Only start if not already running
    service.isRunning().then((isRunning) {
      if (!isRunning) {
        service.startService();
        debugPrint('Background service started successfully');
      } else {
        debugPrint('Background service already running');
      }
    }).catchError((e) {
      debugPrint('Failed to check/start background service: $e');
      // Fallback: try to start anyway
      try {
        service.startService();
      } catch (startError) {
        debugPrint('Final fallback failed: $startError');
      }
    });
  } catch (e) {
    debugPrint('Error in startBackgroundService: $e');
  }
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
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: false,
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: false,
      notificationChannelId: 'madnolia_background',
      initialNotificationTitle: 'Madnolia',
      initialNotificationContent: 'Keeping connections active',
      foregroundServiceNotificationId: 888,
    ),
  );

  return service;
}
