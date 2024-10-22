part of 'sockets_bloc.dart';
enum ServerStatus { online, offline, connecting }

// ignore: must_be_immutable
class SocketsState extends Equatable {
  ServerStatus serverStatus;
  SocketHandler socketHandler;

  
  SocketsState({
    this.serverStatus = ServerStatus.connecting,
    required this.socketHandler,
  });

  SocketsState copyWith({
    ServerStatus? serverStatus,
    SocketHandler? socketHandler
  }) => SocketsState(
    serverStatus: serverStatus ?? this.serverStatus,
    socketHandler: socketHandler ?? this.socketHandler
  );

  
  @override
  List<Object> get props => [serverStatus, socketHandler];
}