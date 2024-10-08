import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/global/environment.dart';
import 'package:Madnolia/main.dart';
import 'package:Madnolia/models/chat/message_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../services/notification_service.dart';
import '../models/invitation_model.dart';

Future<Socket> socketHandler() async {

  final String? token = await const FlutterSecureStorage().read(key: "token");

  final Socket socket = io(
        Environment.socketUrl,
        OptionBuilder()
         .setTransports(['websocket']) // for Flutter or Dart VM
         .enableAutoConnect() // disable auto-connection
         .disableForceNew()
         .disableMultiplex()
         .setExtraHeaders({"token": token ?? ""})
         .build());

  socket.onConnect((_){

    final BuildContext? context = MyApp.navigatorKey.currentContext;

    final userBloc = context?.read<UserBloc>();

    socket.on("message", (payload) async {

      Message message = Message.fromJson(payload);

      final List<String> wordsList = message.text.split(" ");

      List<String> mentions = wordsList
            .where((element) => element == "@${userBloc?.state.username}")
            .toList();
      
      if (mentions.isNotEmpty && message.room != userBloc?.state.chatRoom) {
          await NotificationService.showNotification(
            title: message.user.name,
            body: message.text,
            largeIcon: message.user.thumb,
            summary: message.user.name,
            notificationLayout: NotificationLayout.Messaging,
            // actionButtons: [
            //   NotificationActionButton(
            //     key: "reply",
            //     label: "Reply",
            //     autoDismissible: true,
            //     requireInputText: true,
            //     actionType: ActionType.SilentAction),
            // ],
            payload: {
              "match": message.room
            });
        }

        
      
    });

    socket.on("invitation", (data) async {


      try {
        // Match match = Match.fromJson(data["match"]);
        Invitation match = Invitation.fromJson(data);

        print(socket);
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


  return socket;
}
