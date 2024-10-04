import 'package:Madnolia/utils/socket_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'sockets_event.dart';
part 'sockets_state.dart';

class SocketsBloc extends Bloc<SocketsEvent, SocketsState> {
  
  Socket socket;
  SocketsBloc({required this.socket}) : super(SocketsState(clientSocket: socket)) {
    on<SocketsEvent>((event, emit) async {
      
      if(event is UpdateServerStatus){
        emit(state.copyWith(
          serverStatus: event.serverStatus
        ));
      }

      if(event is UpdatedToken){
        socket = await socketHandler();
      }

      if( event is DisconnectToken){
        socket.disconnect();
      }
    });
  }

  
  void updateServerStatus(ServerStatus status) {
    add(UpdateServerStatus(serverStatus: status));
  } 

  void updateSocket() {
  }

  void disconnect(){
    add(DisconnectToken());
  }


}
