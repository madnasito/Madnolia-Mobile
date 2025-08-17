import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/invitation_model.dart';
import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import '../firebase_options.dart';

/// Define un manejador de nivel superior para mensajes en background
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod") ;
  // Si necesitas usar Firebase en el background handler, debes inicializarlo
  try {
    await Firebase.initializeApp(
      name: 'Madnolia',
      options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      debugPrint('Firebase already initialized in background handler');
    } else {
      rethrow;
    }
  }
  
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint("Message data: ${message.data}");
  
  // Si el mensaje contiene datos, puedes procesarlos aquí
  if (message.data.isNotEmpty) {
    debugPrint("Message data: ${message.data}");
  }

  debugPrint("Message notification: ${message.notification}");
  
  // Si el mensaje contiene notificación, crear una notificación local
  if (message.data.isNotEmpty) {
    await _showNotification(message);
  }
}

/// Mostrar notificación local para mensajes recibidos en background
Future<void> _showNotification(RemoteMessage message) async {

  try {  
    debugPrint(message.data.toString());
    debugPrint(message.data['type']);
    switch (message.data['type']) {
      case 'chat_message':
        final ChatMessage chatMessage = chatMessageFromJson(message.data['data']);
        debugPrint(chatMessage.id);
        // if(chatMessage.type == MessageType.group && chatMessage.text.contains('@'))
        await LocalNotificationsService.displayRoomMessage(chatMessage);
        break;
      case 'match_ready':
        final MatchReady payload = matchReadyFromJson(message.data['data']);
        await LocalNotificationsService.displayMatchReady(payload);
        break;
      case 'invitation':
        final Invitation invitation = invitationFromJson(message.data['data']);
        await LocalNotificationsService.displayInvitation(invitation);
      default:
        debugPrint('Unknow type');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

class FirebaseMessagingService {
  static Future<void> initialize() async {
    // Configurar el manejador de mensajes en background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Solicitar permisos (especialmente importante para iOS)
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // Obtener el token de FCM
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $token');

    // Escuchar cambios en el token
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      debugPrint('FCM Token refreshed: $fcmToken');
    });

    // Manejar mensajes cuando la app está en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      // if (message.notification != null) {
      //   debugPrint('Message also contained a notification: ${message.notification}');
      //   // Mostrar notificación usando el servicio local
      //   _showNotification(message);
      // }
    });

    // Manejar cuando el usuario toca una notificación que abrió la app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint('Message data: ${message.data}');
      
      // Navegar a una pantalla específica basada en los datos del mensaje
      _handleMessageOpenedApp(message);
    });

    // Verificar si la app se abrió desde una notificación
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App opened from terminated state by notification');
      _handleMessageOpenedApp(initialMessage);
    }
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
    // Aquí puedes manejar la navegación basada en los datos del mensaje
    debugPrint('Handling message opened app: ${message.data}');
    
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
    debugPrint('Subscribed to topic: $topic');
  }

  static void unsubscribeFromTopic(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}
