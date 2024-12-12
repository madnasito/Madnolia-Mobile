import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/global/environment.dart';
import 'package:madnolia/main.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/models/match/match_ready_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';


import 'package:socket_io_client/socket_io_client.dart';

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
    
    final service = FlutterBackgroundService();
    
    service.invoke("update_socket", {"socket": socket.receiveBuffer});
    socket.on("message", (payload) async {

    final userBloc = context?.read<UserBloc>();

      Message message = Message.fromJson(payload);

      final List<String> wordsList = message.text.split(" ");

      List<String> mentions = wordsList
            .where((element) => element == "@${userBloc?.state.username}")
            .toList();
      if(userBloc == null) return;

      if (mentions.isNotEmpty && message.to != userBloc.state.chatRoom) {
          // TODO Show notification
        }

        
      
    });

    socket.on("invitation", (data) async {


      try {
        // Match match = Match.fromJson(data["match"]);
        Invitation match = Invitation.fromJson(data);

        // TODO: Show notification

      } catch (e) {
        print(e);
      }
        
      });

    socket.on("match_ready", (data) async {
      MatchReady payload = MatchReady.fromJson(data);
      await LocalNotificationsService.matchReady(payload);
      });
  });

  
  socket.onDisconnect((data) {
    final BuildContext? context = MyApp.navigatorKey.currentContext;

    final socketsBloc = context?.read<SocketsBloc>();

    socketsBloc?.updateServerStatus(ServerStatus.offline);
  });
  return socket;
}
