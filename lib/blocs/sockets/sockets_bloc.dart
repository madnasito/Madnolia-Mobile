
import 'package:madnolia/utils/socket_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'sockets_event.dart';
part 'sockets_state.dart';

class SocketsBloc extends Bloc<SocketsEvent, SocketsState> {
  
  final SocketHandler socketHandler;

  SocketsBloc(this.socketHandler) : super( SocketsState(socketHandler: socketHandler)) {
    on<SocketsEvent>((event, emit) async {
      
      if(event is UpdateServerStatus){
        emit(state.copyWith(
          serverStatus: event.serverStatus
        ));
      }

      if(event is UpdateToken){
        state.socketHandler.updateToken(event.token);
        final Socket newSocket = await socketConnection();
        final handler = state.socketHandler;
        handler.socket = newSocket;
        
        emit(state.copyWith(
          socketHandler: handler
        ));
      }

      if( event is DisconnectToken){
        final disconnectedHandler = SocketHandler();
        emit(state.copyWith(
          socketHandler: disconnectedHandler
        ));
      }

      if(event is UpdateSocketClient){
        final newState = state;
        newState.socketHandler.socket = event.socket;

        emit(state.copyWith(
          socketHandler: newState.socketHandler
        ));
        
      }
    });
  }

  
  void updateServerStatus(ServerStatus status) {
    add(UpdateServerStatus(serverStatus: status));
  }

  void updateToken(String token){
    add(UpdateToken(token: token));
  }

  void updateSocket(Socket socket) {
    add(UpdateSocketClient(socket: socket));
  }

  void connect(){
    add(ConnectSockets());
  }

  void disconnect(){
    add(DisconnectToken());
  }

}
