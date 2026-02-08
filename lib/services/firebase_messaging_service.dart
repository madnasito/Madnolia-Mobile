import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:madnolia/models/connection/accepted_connection_model.dart';
import 'package:madnolia/models/invitation_model.dart';
import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../firebase_options.dart';
import '../models/friendship/connection_request.dart';

final talker = Talker();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  (kDebugMode)
      ? await dotenv.load(fileName: "assets/.env.dev")
      : await dotenv.load(fileName: "assets/.env.prod");
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      talker.warning('Firebase already initialized in background handler');
    } else {
      talker.handle(e);
      rethrow;
    }
  }

  talker.debug("Handling a background message: ${message.messageId}");
  talker.debug("Message data: ${message.data}");

  if (message.data.isNotEmpty) {
    talker.debug("Message data: ${message.data}");
  }

  talker.debug("Message notification: ${message.notification}");

  if (message.data.isNotEmpty) {
    await _showNotification(message);
  }
}

Future<void> _showNotification(RemoteMessage message) async {
  try {
    final storage = FlutterSecureStorage();
    String? userId = await storage.read(key: 'userId');
    talker.debug(message.data.toString());
    talker.debug(message.data['type']);
    switch (message.data['type']) {
      case 'chat_message':
        final ChatMessage chatMessage = chatMessageFromJson(
          message.data['data'],
        );
        talker.debug(chatMessage.id);

        const storage = FlutterSecureStorage();

        String? userId = await storage.read(key: 'userId');

        if ((chatMessage.type == ChatMessageType.match ||
                chatMessage.type == ChatMessageType.group) &&
            chatMessage.creator != userId) {
          String? username = await storage.read(key: 'username');

          if (username == null) return;

          // Regular expression to get the mention as a full word
          final mentionRegex = RegExp(
            r'(^|\s)@' + RegExp.escape(username) + r'(\s|$)',
          );

          if (!mentionRegex.hasMatch(chatMessage.content)) return;
        }
        await LocalNotificationsService.displayRoomMessage(chatMessage);
        break;
      case 'match_ready':
        final MatchReady payload = matchReadyFromJson(message.data['data']);
        await RepositoryManager().match.updateMatchStatus(
          payload.match,
          MatchStatus.running,
        );
        await LocalNotificationsService.displayMatchReady(payload);
        break;
      case 'invitation':
        final Invitation invitation = invitationFromJson(message.data['data']);
        await LocalNotificationsService.displayInvitation(invitation);
        break;
      case 'new_request_connection':
        final ConnectionRequest connectionRequest = connectionRequestFromJson(
          message.data['data'],
        );
        if (userId == connectionRequest.sender) return;
        await LocalNotificationsService.requestConnection(connectionRequest);
        break;
      case 'request_accepted':
        final AcceptedConnection acceptedConnection =
            acceptedConnectionFromJson(message.data['data']);
        if (userId == acceptedConnection.request.receiver) return;
        await LocalNotificationsService.requestAccepted(acceptedConnection);
        break;
      default:
        talker.warning('Unknow type');
    }
  } catch (e) {
    talker.handle(e);
  }
}

class FirebaseMessagingService {
  static Future<void> initialize() async {
    // Configurar el manejador de mensajes en background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      talker.debug('This come from the listen');
      talker.debug('Message data: $message');

      // if (message.data.isNotEmpty) {
      //   await _showNotification(message);
      // }
    });

    // Solicitar permisos (especialmente importante para iOS)
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

    talker.debug('User granted permission: ${settings.authorizationStatus}');

    // Obtener el token de FCM
    String? token = await FirebaseMessaging.instance.getToken();
    talker.debug('FCM Token: $token');

    // Escuchar cambios en el token
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      talker.debug('FCM Token refreshed: $fcmToken');
    });

    // Manejar mensajes cuando la app está en foreground
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   debugPrint('Got a message whilst in the foreground!');
    //   debugPrint('Message data: ${message.data}');

    //   AndroidNotification? android = message.notification!.android;

    //   if (message.notification != null && android != null) {
    //     debugPrint('Message also contained a notification: ${message.notification}');
    //     // Mostrar notificación usando el servicio local
    //     _showNotification(message);
    //   }
    // });

    // Manejar cuando el usuario toca una notificación que abrió la app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      talker.debug('A new onMessageOpenedApp event was published!');
      talker.debug('Message data: ${message.data}');

      // Navegar a una pantalla específica basada en los datos del mensaje
      _handleMessageOpenedApp(message);
    });

    // Verificar si la app se abrió desde una notificación
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      talker.debug('App opened from terminated state by notification');
      _handleMessageOpenedApp(initialMessage);
    }
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
    // Aquí puedes manejar la navegación basada en los datos del mensaje
    talker.debug('Handling message opened app: ${message.data}');

    // Ejemplo: navegar a una pantalla específica
    // if (message.data['type'] == 'chat') {
    //   navigatorKey.currentState?.pushNamed('/chat/${message.data['chatId']}');
    // }
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static void subscribeToTopic(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
    talker.log('Subscribed to topic: $topic');
  }

  static void unsubscribeFromTopic(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    talker.log('Unsubscribed from topic: $topic');
  }
}
