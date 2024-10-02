part of 'sockets_bloc.dart';
enum ServerStatus { online, offline, connecting }

// ignore: must_be_immutable
class SocketsState extends Equatable {
  ServerStatus serverStatus;
  Socket clientSocket; // Use a nullable type

  
  SocketsState({
    this.serverStatus = ServerStatus.connecting,
    required this.clientSocket,
  });

  SocketsState copyWith({
    ServerStatus? serverStatus,
    Socket? clientSocket
  }) => SocketsState(
    serverStatus: serverStatus ?? this.serverStatus,
    clientSocket: clientSocket ?? this.clientSocket
  );

  
  @override
  List<Object> get props => [serverStatus, clientSocket];
}