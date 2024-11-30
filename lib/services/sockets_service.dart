import 'dart:async';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/global/environment.dart';
import 'package:madnolia/models/invitation_model.dart';
import 'package:madnolia/services/notification_service.dart';
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
          .enableAutoConnect()
          .enableReconnection()
          .setAuth({"token": token})
          .setExtraHeaders({"token": token})
          .build());

    socket.onConnect((_) async {

      print('Connected. Socket ID: ${socket.id}');

      print(socket.id);
      socket.on("message", (payload) async {

        print("MESSAGE!!!");
        print(payload);
        Message message = Message.fromJson(payload);

        // if (mentions.isNotEmpty && message.to != userBloc.state.chatRoom) {
            await NotificationService.showNotification(
              
              title: message.user.name,
              body: message.text,
              // largeIcon: message.user.thumb,
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
                "match": message.to
              });
          // }

        
        
      });

      socket.on("invitation", (data) async {


        try {
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
              bigPicture: match.img,
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
                  color: Colors.blueGrey,
                )
              ]);
        } catch (e) {
          print(e);
        }
          
        });

      socket.on("match_ready", (data) async {
        print("NOW ON BACKGROUND");
        print(data);
          // Match match = Match.fromJson(data["match"]);
          await NotificationService.showNotification(
              title: "The match is ready",
              body: data["title"],
              actionButtons: [],
              payload: {"match": data["match"]});
        });
      service.on("stop").listen((event) {
        service.stopSelf();
        print("background process is now stopped");
      });

      service.on("start").listen((event) {
        print("Service start");
      });

      print(service);

      service.on("message").listen((payload){
        print(payload);
      });

    });

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
  static Future<bool> startOnIos(ServiceInstance service) async => onIosBackground(service);
  
  
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