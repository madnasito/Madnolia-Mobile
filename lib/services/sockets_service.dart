import 'dart:async';
import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/models/chat/update_recipient_model.dart';
import 'package:madnolia/models/friendship/connection_request.dart';
import 'package:madnolia/models/match/match_ready_model.dart' show MatchReady;
import 'package:madnolia/services/firebase_messaging_service.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


import '../models/invitation_model.dart' show Invitation;


@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  debugPrint('Background service starting...');

  // Load environment variables FIRST before Firebase initialization
  try {
    (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod");
  } catch (e) {
    debugPrint('Error loading dotenv in background service: $e');
  }
  
  final chatMessageRepository = RepositoryManager().chatMessage;
  final matchRepository = RepositoryManager().match;
  final notificationsRepository = RepositoryManager().notification;
  
  // Initialize Firebase after dotenv is loaded
  try {
    await Firebase.initializeApp(
      name: 'Madnolia',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessagingService.initialize();
  } catch (e) {
    debugPrint('Firebase already initialized or error: $e');
  }
  
  // Crear el canal de notificaciones INMEDIATAMENTE
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'silent_service_channel',
      'Background Service',
      description: 'Keeps your gaming connections active',
      importance: Importance.low,
      playSound: false,
      enableVibration: false,
      showBadge: false,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
        
    debugPrint('Notification channel created successfully in service');
  } catch (e) {
    debugPrint('Error creating notification channel: $e');
  }
  
  // Pequeño delay para asegurar que el canal esté creado
  await Future.delayed(const Duration(milliseconds: 500));
  
  try {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    // dotenv is already loaded at the beginning of the function
    final String socketsUrl = dotenv.get("SOCKETS_URL");

   await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // await FirebaseMessaging.instance.requestPermission(provisional: true);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $fcmToken');
    debugPrint('APNS Token: $apnsToken');
    if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
    }

    FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      debugPrint('New FCM token: $fcmToken');

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      debugPrint('Error getting FCM token: $err');
      // Error getting token.
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received a message while in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });
  final Socket socket = io(
    socketsUrl,
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .enableReconnection()
      .disableForceNew()
      .setAuth({"token": token})
      .setExtraHeaders({"fcm_token": fcmToken})
      .build(),
  );

  String currentRoom = "";
  String username = "";
  String? userId = await storage.read(key: "userId");

  socket.onConnect((_) async {

    debugPrint('Connected. Socket ID: ${socket.id}');

    service.invoke("connected_socket");

    if(await storage.containsKey(key: 'lastSyncDate')) {
      debugPrint('Starting syncing');
      final String? dateString = await storage.read(key: 'lastSyncDate');
      if(dateString != '' && dateString != null){
        debugPrint('Starting syncing from date $dateString');
        final date = DateTime.parse(dateString);
        await chatMessageRepository.syncFromDate(date.toUtc());
      }
    }

  });

  socket.on('update_availability', (payload) => service.invoke('update_availability', {'availability': payload}));

  socket.on("added_to_match", (payload) => service.invoke("added_to_match", {"resp" : payload}));

  socket.on("left_match", (payload) => service.invoke("left_match", {"resp" : payload}));
  
  socket.on("player_left_match", (payload) => service.invoke("player_left_match", {"resp" : payload}));

  socket.on("message", (payload) async {

    try {
      debugPrint("MESSAGE!!!");
      debugPrint(username);
      debugPrint(currentRoom);
      service.invoke("message", payload);

      ChatMessage message = ChatMessage.fromJson(payload);

      final messageDbSaved = await chatMessageRepository.createOrUpdate(message.toCompanion());

      debugPrint('message saved: $messageDbSaved');

      if(message.creator == userId) return LocalNotificationsService.deleteRoomMessages(message.conversation);

      if(currentRoom != payload["conversation"] ) {
        // if(message.text.contains("@$username") &&)
        
        final mentionRegex = RegExp(r'(^|\s)@' + RegExp.escape(username) + r'(\s|$)');

        if(message.type == ChatMessageType.user){ LocalNotificationsService.displayRoomMessage(message);}
        else if(message.type == ChatMessageType.match && mentionRegex.hasMatch(message.content)) {LocalNotificationsService.displayRoomMessage(message);}
      }
      
    } catch (e) {
      debugPrint(e.toString());
    }
    });
  
  socket.on('sended_message', (payload) async  {
    final messageDb = await chatMessageRepository.messageSended(payload['uid'], payload['message']['id'], DateTime.parse(payload['message']['date']));
    debugPrint('Message sended saved $messageDb');
  });

  socket.on("message_recipient_update", (payload) async {
    try {
      
      final data = UpdateRecipientModel.fromJson(payload);
      await chatMessageRepository.updateMessageStatus(data.id, data.status);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  } );

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

      try {
        
        final MatchReady payload = MatchReady.fromJson(data);
        
        LocalNotificationsService.displayMatchReady(payload);
      } catch (e) {
        debugPrint(e.toString());
      }
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
  socket.on("connection_accepted", (data) async {
    try {
      service.invoke("connection_accepted", data);
      final connectionRequest = ConnectionRequest.fromJson(data);
      if(userId == connectionRequest.sender) return;
      final int deletedNotification = await notificationsRepository.deleteRequestNotification(senderId: connectionRequest.sender);
      debugPrint('Deleted request notification: $deletedNotification');
    } catch (e) {
      debugPrint(e.toString());
    }
  } );
  socket.on("removed_partner", (data) => service.invoke("removed_partner"));
  socket.on("connection_rejected", (data) async {
    try {
      final connectionRequest = ConnectionRequest.fromJson(data);
      if(userId == connectionRequest.sender) return;
      final int deletedNotification = await notificationsRepository.deleteRequestNotification(senderId: connectionRequest.sender);
      debugPrint('Deleted request notification: $deletedNotification');
    } catch (e) {
      debugPrint(e.toString());
    }
  } );
  socket.on("canceled_connection", (data) => service.invoke("canceled_connection", data));

  socket.on('notification_deleted', (data) async {
    try {
      await notificationsRepository.deleteNotification(id: data);
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  socket.on('match_cancelled', (data) async => await matchRepository.updateMatchStatus(data['match'], MatchStatus.cancelled));

  socket.onDisconnect((_) {
    service.invoke("disconnected_socket");
    storage.write(key: 'lastSyncDate', value: DateTime.now().toUtc().toIso8601String());
    }
  );

  service.on("update_socket").listen((event) {
    debugPrint("Update socket");
    debugPrint(event.toString());
  });
  
  service.on("update_username").listen((onData) {
    username = onData?["username"];
    storage.write(key: 'username', value: username);
  });

  service.on('match_created').listen((onData) => socket.emit('match_created', onData?['id']));

  service.on('join_to_match').listen((onData) => socket.emit('join_to_match', onData?['match']));

  service.on('is_socket_connected').listen((data) => service.invoke('socket_status', {'connected': socket.connected}));

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

  service.on("new_message").listen((onData) async {
    try {
      final message = CreateMessage.fromJson(onData!);
      final result = await chatMessageRepository.createOrUpdate(
        ChatMessageCompanion(
          content: Value(message.content),
          conversation: Value(message.conversation),
          creator: Value(userId!),
          date: Value(DateTime.now()),
          id: Value(message.id),
          status: Value(ChatMessageStatus.sent),
          type: Value(message.type),
          pending: Value(true)
        )
      );

      debugPrint(result.toString());
      socket.emitWithAck("message", onData);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  });

  service.on("update_recipient_status").listen((onData) => socket.emit("update_recipient_status", onData));

  service.on("disconnect_chat").listen((onData) {
    socket.emit("disconnect_chat");
    currentRoom = "";
  });

  service.on("leave_room").listen((onData) {
    debugPrint("LEAVE ROOM");
    currentRoom = "";
  });

  service.on('update_availability').listen((onData) => socket.emit('update_availability', onData?['availability']));

  service.on("logout").listen((onData) => socket.emit("logout"));

  service.on("new_player_to_match").listen((onData) async => await matchRepository.joinUser(onData?['match'], onData?['user']));

  service.on("join_to_match").listen((onData) => socket.emit("join_to_match", onData?["match"]));

  service.on("leave_match").listen((onData) => socket.emit("leave_match", onData?["match"]));

  service.on("make_call").listen((onData) => socket.emit("make_call", onData));

  service.on("answer_call").listen((onData) => socket.emit("answer_call", onData));

  service.on("ice_candidate").listen((onData) => socket.emit("ice_candidate", onData));

  service.on("join_call_room").listen((onData) => socket.emit("join_call_room", onData));

  service.on("leave_call_room").listen((onData) => socket.emit("leave_call_room", onData));

  service.on("make_room_call").listen((onData) => socket.emit("make_room_call", onData));

  service.on("answer_room_call").listen((onData) => socket.emit("answer_room_call", onData));

  service.on("room_ice_candidate").listen((onData) => socket.emit("room_ice_candidate", onData));

  service.on("delete_notification").listen((onData) {
    try {
      final String id = onData?['id'];

      socket.emitWithAck('delete_notification', id, ack: (value) async {
        debugPrint('Deleted notification socket, $id');
        debugPrint(value.toString());
        await notificationsRepository.deleteNotification(id: id);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    
  });

  service.on("delete_chat_notifications").listen((onData) => LocalNotificationsService.deleteRoomMessages(onData?["room"]));

  service.on("delete_all_notifications").listen((onData)=> LocalNotificationsService.deleteAllNotifications());

  // Events for handle connections
  service.on('request_connection').listen((onData) => socket.emit('request_connection', onData?['user']));
  service.on('accept_connection').listen((onData) => socket.emit('accept_connection', onData?['user']));
  service.on('reject_connection').listen((onData) => socket.emit('reject_connection', onData?['user']));
  service.on('cancel_connection').listen((onData) => socket.emit('cancel_connection', onData?['user']));

  } catch (e) {
    debugPrint('Error initializing background service: $e');
    // El servicio ya está en foreground, por lo que continuará funcionando
    // aunque haya errores en la inicialización
  }
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

Future<FlutterBackgroundService> initializeService() async {
  final service = FlutterBackgroundService();
  
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: false, // No auto-iniciar, se controla manualmente
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: false, // IMPORTANTE: false para evitar inicio automático
      onStart: onStart,
      isForegroundMode: false, // CAMBIAR A FALSE temporalmente
      autoStartOnBoot: false,
      notificationChannelId: 'silent_service_channel',
      initialNotificationTitle: 'Madnolia Service',
      initialNotificationContent: translate('UTILS.KEEPING_CONNECTIONS'),
      foregroundServiceNotificationId: 888,
    ),
  );

  return service;
}
