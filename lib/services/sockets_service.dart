import 'dart:async';
import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/enums/events/sockets_events.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:madnolia/models/chat/chat_sended_message.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/models/chat/update_recipient_model.dart';
import 'package:madnolia/models/friendship/connection_request.dart';
import 'package:madnolia/models/match/match_ready_model.dart' show MatchReady;
import 'package:madnolia/models/notification/notification_model.dart';
import 'package:madnolia/services/firebase_messaging_service.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../firebase_options.dart';

import '../models/connection/accepted_connection_model.dart';
import '../models/invitation_model.dart' show Invitation;

final talker = Talker();
@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  talker.info('Background service starting...');

  // Load environment variables FIRST before Firebase initialization
  try {
    (kDebugMode)
        ? await dotenv.load(fileName: "assets/.env.dev")
        : await dotenv.load(fileName: "assets/.env.prod");
  } catch (e) {
    talker.error('Error loading dotenv in background service: $e');
  }

  final chatMessageRepository = RepositoryManager().chatMessage;
  final matchRepository = RepositoryManager().match;
  final notificationsRepository = RepositoryManager().notification;

  // Initialize Firebase after dotenv is loaded
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessagingService.initialize();
  } catch (e) {
    talker.handle('Firebase already initialized or error: $e');
  }

  // Crear el canal de notificaciones INMEDIATAMENTE
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

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
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    talker.info('Notification channel created successfully in service');
  } catch (e) {
    talker.error('Error creating notification channel: $e');
  }

  try {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    talker.debug('Background service: token present: ${token != null}');

    // dotenv is already loaded at the beginning of the function
    final String socketsUrl = dotenv.get("SOCKETS_URL");
    talker.info('Background service: socketsUrl: $socketsUrl');

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // await FirebaseMessaging.instance.requestPermission(provisional: true);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    talker.debug('Background service: FCM Token: $fcmToken');
    talker.debug('Background service: APNS Token: $apnsToken');
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    }

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
          talker.debug('New FCM token: $fcmToken');

          // Note: This callback is fired at each app startup and whenever a new
          // token is generated.
        })
        .onError((err) {
          talker.error('Error getting FCM token: $err');
          // Error getting token.
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      talker.debug('Received a message while in the foreground!');
      talker.debug('Message data: ${message.data}');

      if (message.notification != null) {
        talker.debug(
          'Message also contained a notification: ${message.notification}',
        );
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

    talker.debug('Background service: socket initialization completed');

    String currentRoom = "";
    String username = "";
    String? userId = await storage.read(key: "userId");
    talker.debug('Background service: userId present: ${userId != null}');
    final Set<String> inFlightMessages = {};

    service.invoke("service_started");
    socket.onConnect((_) async {
      talker.debug(
        'Background service: socket connected. Socket ID: ${socket.id}',
      );

      service.invoke("connected_socket");

      if (await storage.containsKey(key: 'lastSyncDate')) {
        talker.debug('Background service: starting syncing');
        final String? dateString = await storage.read(key: 'lastSyncDate');
        if (dateString != '' && dateString != null) {
          final date = DateTime.parse(dateString);
          await chatMessageRepository.syncFromDate(date.toUtc());
        }
      }

      talker.debug('Background service: checking for pending messages...');
      final sentMessages = await chatMessageRepository.getAllSentMessages();
      talker.debug(
        'Background service: found ${sentMessages.length} pending messages',
      );
      for (var message in sentMessages) {
        if (inFlightMessages.contains(message.id)) {
          talker.debug(
            'Background service: message ${message.id} already in flight, skipping',
          );
          continue;
        }

        talker.debug(
          'Background service: emitting pending message: ${message.id}',
        );
        inFlightMessages.add(message.id);

        final newMessage = CreateMessage(
          id: message.id,
          conversation: message.conversation,
          content: message.content,
          type: message.type,
        );

        socket.emitWithAck(
          ChatMessageEvents.message.event,
          newMessage.toJson(),
          ack: (data) {
            talker.debug(
              'Background service: ack received for message: ${message.id}',
            );
            inFlightMessages.remove(message.id);
          },
        );
      }
    });

    socket.on(
      UserEvents.updateAvailability.event,
      (payload) => service.invoke(UserEvents.updateAvailability.event, {
        'availability': payload,
      }),
    );

    // socket.on(
    //   "added_to_match",
    //   (payload) => service.invoke("added_to_match", {"resp": payload}),
    // );

    // socket.on(
    //   "left_match",
    //   (payload) => service.invoke("left_match", {"resp": payload}),
    // );

    socket.on(
      MatchEvents.playerLeftMatch.event,
      (payload) =>
          service.invoke(MatchEvents.playerLeftMatch.event, {"resp": payload}),
    );

    socket.on(ChatMessageEvents.message.event, (payload) async {
      try {
        talker.debug("MESSAGE!!!");
        talker.debug(username);
        talker.debug(currentRoom);
        service.invoke("message", payload);

        ChatMessage message = ChatMessage.fromJson(payload);

        final messageDbSaved = await chatMessageRepository.createOrUpdate(
          message.toCompanion(),
        );

        talker.debug('message saved: $messageDbSaved');

        if (message.creator == userId) {
          return LocalNotificationsService.deleteRoomMessages(
            message.conversation,
          );
        }

        if (currentRoom != payload["conversation"]) {
          // if(message.text.contains("@$username") &&)

          final mentionRegex = RegExp(
            r'(^|\s)@' + RegExp.escape(username) + r'(\s|$)',
          );

          if (message.type == ChatMessageType.user) {
            LocalNotificationsService.displayRoomMessage(message);
          } else if (message.type == ChatMessageType.match &&
              mentionRegex.hasMatch(message.content)) {
            LocalNotificationsService.displayRoomMessage(message);
          }
        }
      } catch (e) {
        talker.handle(e);
      }
    });

    socket.on(ChatMessageEvents.sendedMessage.event, (payload) async {
      try {
        final chagMessageSended = ChatMessageSendedI.fromJson(payload);
        final messageDb = await chatMessageRepository.messageSended(
          chagMessageSended.uid,
          chagMessageSended.message.id,
          chagMessageSended.message.date,
        );
        talker.debug('Message sended saved $messageDb');
      } catch (e, stackTrace) {
        talker.handle(e, stackTrace);
      }
    });

    socket.on(ChatMessageEvents.messageRecipientUpdate.event, (payload) async {
      try {
        final data = UpdateRecipientModel.fromJson(payload);
        await chatMessageRepository.updateMessageStatus(data.id, data.status);
      } catch (e) {
        talker.handle(e);
        rethrow;
      }
    });

    socket.on(MatchEvents.invitation.event, (data) async {
      try {
        service.invoke(MatchEvents.invitation.event, data);
        Invitation invitation = Invitation.fromJson(data);

        LocalNotificationsService.displayInvitation(invitation);
      } catch (e) {
        talker.handle(e);
      }
    });

    socket.on(MatchEvents.matchReady.event, (data) async {
      talker.debug("NOW ON BACKGROUND");
      talker.debug(data.toString());

      try {
        final MatchReady payload = MatchReady.fromJson(data);

        LocalNotificationsService.displayMatchReady(payload);
      } catch (e) {
        talker.handle(e);
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
    socket.on(
      "room_call_answered",
      (data) => service.invoke("room_call_answered", data),
    );
    socket.on(
      "room_ice_candidate",
      (data) => service.invoke("room_ice_candidate", data),
    );

    // Events for handle user connections
    socket.on(UserEvents.newRequestConnection.event, (data) {
      service.invoke(UserEvents.newRequestConnection.event, data);
      try {
        final connectionRequest = ConnectionRequest.fromJson(data);
        if (userId == connectionRequest.sender) return;
        talker.info(connectionRequest.toJson());
        LocalNotificationsService.requestConnection(connectionRequest);
      } catch (e) {
        talker.error(e);
        talker.handle(e);
      }
    });
    socket.on(UserEvents.requestAccepted.event, (data) async {
      try {
        service.invoke(UserEvents.requestAccepted.event, data);
        talker.info(data.toString());
        final acceptedConnection = AcceptedConnection.fromJson(data);
        if (userId == acceptedConnection.request.sender) {
          LocalNotificationsService.requestAccepted(acceptedConnection);
          return;
        }

        final int deletedNotification = await notificationsRepository
            .deleteRequestNotification(
              senderId: acceptedConnection.request.sender,
            );
        talker.debug('Deleted request notification: $deletedNotification');
      } catch (e) {
        talker.error('error here 1 $e');
        talker.handle(e);
      }
    });
    socket.on(
      UserEvents.removedPartner.event,
      (data) => service.invoke(UserEvents.removedPartner.event),
    );
    socket.on(UserEvents.connectionRejected.event, (data) async {
      try {
        service.invoke(UserEvents.connectionRejected.event, data);
        final connectionRequest = ConnectionRequest.fromJson(data);
        if (userId == connectionRequest.sender) return;
        final int deletedNotification = await notificationsRepository
            .deleteRequestNotification(senderId: connectionRequest.sender);
        talker.debug('Deleted request notification: $deletedNotification');
      } catch (e) {
        talker.handle(e);
      }
    });
    socket.on(
      UserEvents.connectionCanceled.event,
      (data) => service.invoke(UserEvents.connectionCanceled.event, data),
    );

    socket.on(UserEvents.connectionRejected.event, (data) {
      talker.info(data.toString());
      service.invoke(UserEvents.connectionRejected.event, data);
    });

    // Events to handle notifications
    socket.on(UserEvents.readNotification.event, (data) async {
      try {
        await notificationsRepository.readAllNotifications();
      } catch (e) {
        talker.handle(e);
      }
    });
    socket.on(NotificationEvents.notificationDeleted.event, (data) async {
      try {
        await notificationsRepository.deleteNotification(id: data);
      } catch (e) {
        talker.handle(e);
      }
    });

    socket.on(
      MatchEvents.cancelled.event,
      (data) async =>
          await matchRepository.updateMatchStatus(data, MatchStatus.cancelled),
    );

    socket.on(NotificationEvents.standardNotification.event, (data) async {
      try {
        final notification = NotificationModel.fromJson(data);
        final notificationCompanion = notification.toCompanion();
        await notificationsRepository.insertNotification(notificationCompanion);
      } catch (e) {
        talker.handle(e);
      }
    });

    socket.on(UserEvents.readNotification.event, (data) async {
      try {
        await notificationsRepository.readAllNotifications();
      } catch (e) {
        talker.handle(e);
      }
    });

    socket.onDisconnect((_) {
      service.invoke("disconnected_socket");
      storage.write(
        key: 'lastSyncDate',
        value: DateTime.now().toUtc().toIso8601String(),
      );
    });

    service.on(UserEvents.updateUserName.event).listen((onData) {
      username = onData?["username"];
      storage.write(key: 'username', value: username);
    });

    service
        .on(MatchEvents.joinToMatch.event)
        .listen(
          (onData) =>
              socket.emit(MatchEvents.joinToMatch.event, onData?['match']),
        );

    service
        .on('is_socket_connected')
        .listen(
          (data) =>
              service.invoke('socket_status', {'connected': socket.connected}),
        );

    service.on("stop").listen((event) {
      socket.disconnect();
      service.stopSelf();
      talker.debug("background process is now stopped");
    });

    service.on(ChatMessageEvents.initChat.event).listen((onData) {
      socket.emit(ChatMessageEvents.initChat.event, {onData?["room"]});
      currentRoom = onData?["room"];
      talker.debug("INIT CHAT: ${onData?["room"]}");
      LocalNotificationsService.deleteRoomMessages(onData?["room"]);
    });

    service.on(ChatMessageEvents.joinRoom.event).listen((onData) {
      currentRoom = onData?["room"];
      talker.debug("INIT CHAT: ${onData?["room"]}");
      LocalNotificationsService.deleteRoomMessages(onData?["room"]);
    });

    service.on(ChatMessageEvents.newMessage.event).listen((onData) async {
      try {
        talker.debug("Background service: new_message event received");
        talker.debug(onData.toString());
        final message = CreateMessage.fromJson(onData!);
        talker.debug('Background service: using userId: ${userId!}');
        final result = await chatMessageRepository.createOrUpdate(
          ChatMessageCompanion(
            id: Value(message.id),
            creator: Value(userId),
            conversation: Value(message.conversation),
            content: Value(message.content),
            type: Value(message.type),
            date: Value(DateTime.now()),
            status: Value(ChatMessageStatus.sent),
            pending: Value(true),
          ),
        );

        talker.debug(
          'Background service: local message saved: ${result.toString()}',
        );

        if (inFlightMessages.contains(message.id)) {
          talker.debug(
            'Background service: message ${message.id} already in flight, skipping emission',
          );
          return;
        }
        inFlightMessages.add(message.id);

        talker.debug('Background service: emitting message ${message.id}');
        socket.emitWithAck(
          ChatMessageEvents.message.event,
          onData,
          ack: (data) {
            talker.debug(
              'Background service: ack received for message ${message.id}',
            );
            inFlightMessages.remove(message.id);
          },
        );
      } catch (e) {
        talker.handle(e);
        rethrow;
      }
    });

    service
        .on(ChatMessageEvents.updateRecipientStatus.event)
        .listen(
          (onData) => socket.emit(
            ChatMessageEvents.updateRecipientStatus.event,
            onData,
          ),
        );

    service.on(ChatMessageEvents.disconnectChat.event).listen((onData) {
      socket.emit(ChatMessageEvents.disconnectChat.event);
      currentRoom = "";
    });

    service.on(ChatMessageEvents.leaveRoom.event).listen((onData) {
      talker.debug("LEAVE ROOM");
      currentRoom = "";
    });

    service
        .on(UserEvents.updateAvailability.event)
        .listen(
          (onData) => socket.emit(
            UserEvents.updateAvailability.event,
            onData?['availability'],
          ),
        );

    service
        .on(UserEvents.logout.event)
        .listen((onData) => socket.emit(UserEvents.logout.event));

    service
        .on(MatchEvents.newPlayerToMatch.event)
        .listen(
          (onData) async => await matchRepository.joinUser(
            onData?['match'],
            onData?['player'],
          ),
        );

    service
        .on(MatchEvents.joinToMatch.event)
        .listen(
          (onData) =>
              socket.emit(MatchEvents.joinToMatch.event, onData?["match"]),
        );

    service
        .on(MatchEvents.leaveMatch.event)
        .listen(
          (onData) =>
              socket.emit(MatchEvents.leaveMatch.event, onData?["match"]),
        );

    service
        .on("make_call")
        .listen((onData) => socket.emit("make_call", onData));

    service
        .on("answer_call")
        .listen((onData) => socket.emit("answer_call", onData));

    service
        .on("ice_candidate")
        .listen((onData) => socket.emit("ice_candidate", onData));

    service
        .on("join_call_room")
        .listen((onData) => socket.emit("join_call_room", onData));

    service
        .on("leave_call_room")
        .listen((onData) => socket.emit("leave_call_room", onData));

    service
        .on("make_room_call")
        .listen((onData) => socket.emit("make_room_call", onData));

    service
        .on("answer_room_call")
        .listen((onData) => socket.emit("answer_room_call", onData));

    service
        .on("room_ice_candidate")
        .listen((onData) => socket.emit("room_ice_candidate", onData));

    // Notifications events
    service.on(NotificationEvents.delete.event).listen((onData) {
      try {
        final String id = onData?['id'];

        socket.emitWithAck(
          NotificationEvents.delete.event,
          id,
          ack: (value) async {
            talker.info('Deleted notification socket, $id');
            talker.info(value.toString());
            await notificationsRepository.deleteNotification(id: id);
          },
        );
      } catch (e) {
        talker.error(e.toString());
      }
    });
    service
        .on(NotificationEvents.deleteChatNotifications.event)
        .listen(
          (onData) =>
              LocalNotificationsService.deleteRoomMessages(onData?["room"]),
        );
    service
        .on(NotificationEvents.deleteAllNotifications.event)
        .listen((onData) => LocalNotificationsService.deleteAllNotifications());
    service.on(UserEvents.readAllNotifications.event).listen((onData) async {
      try {
        final count = await notificationsRepository.unreadNotificationsCount();
        if (count > 0) socket.emit(UserEvents.readAllNotifications.event);
      } catch (e) {
        talker.error(e.toString());
      }
    });

    // Events for handle connections
    service
        .on(UserEvents.requestConnection.event)
        .listen(
          (onData) =>
              socket.emit(UserEvents.requestConnection.event, onData?['user']),
        );
    service
        .on(UserEvents.acceptRequest.event)
        .listen(
          (onData) =>
              socket.emit(UserEvents.acceptRequest.event, onData?['user']),
        );
    service
        .on(UserEvents.rejectConnection.event)
        .listen(
          (onData) =>
              socket.emit(UserEvents.rejectConnection.event, onData?['user']),
        );
    service
        .on(UserEvents.cancelConnection.event)
        .listen(
          (onData) =>
              socket.emit(UserEvents.cancelConnection.event, onData?['user']),
        );
  } catch (e) {
    talker.handle(e);
    // El servicio ya está en foreground, por lo que continuará funcionando
    // aunque haya errores en la inicialización
  }
}

void startBackgroundService() {
  try {
    final service = FlutterBackgroundService();

    // Only start if not already running
    service
        .isRunning()
        .then((isRunning) {
          if (!isRunning) {
            service.startService();
            talker.debug('Background service started successfully');
          } else {
            talker.debug('Background service already running');
          }
        })
        .catchError((e) {
          talker.handle(e);
          // Fallback: try to start anyway
          try {
            service.startService();
          } catch (startError) {
            talker.handle(startError);
          }
        });
  } catch (e) {
    talker.handle(e);
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
      initialNotificationContent: t.UTILS.KEEPING_CONNECTIONS,
      foregroundServiceNotificationId: 888,
    ),
  );

  return service;
}
