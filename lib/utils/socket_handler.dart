import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/global/environment.dart';
import 'package:madnolia/main.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:socket_io_client/socket_io_client.dart';

import '../services/notification_service.dart';
import '../models/invitation_model.dart';

class SocketHandler {
  String token = "";

  late Socket socket;

  SocketHandler();

  updateSocket(Socket socket){
    this.socket = socket;
  }

  updateToken(String token){
    this.token = token;
  }

  connect() async{
    socket = await socketConnection();
    socket.connect();
  }

}

Future<Socket> socketConnection() async {  


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

    final BuildContext? context = MyApp.navigatorKey.currentContext;

    final socketsBloc = context?.read<SocketsBloc>();

    socketsBloc?.updateServerStatus(ServerStatus.online);
    
    socket.on("message", (payload) async {


    final userBloc = context?.read<UserBloc>();

      Message message = Message.fromJson(payload);

      final List<String> wordsList = message.text.split(" ");

      List<String> mentions = wordsList
            .where((element) => element == "@${userBloc?.state.username}")
            .toList();
      if(userBloc == null) return;

      if (mentions.isNotEmpty && message.to != userBloc.state.chatRoom) {
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
        }

        
      
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
        // Match match = Match.fromJson(data["match"]);
        await NotificationService.showNotification(
            title: "The match is ready",
            body: data["title"],
            actionButtons: [],
            payload: {"match": data["match"]});
      });
  });

  
  socket.onDisconnect((data) {
    final BuildContext? context = MyApp.navigatorKey.currentContext;

    final socketsBloc = context?.read<SocketsBloc>();

    socketsBloc?.updateServerStatus(ServerStatus.offline);
  });
  return socket;
}
