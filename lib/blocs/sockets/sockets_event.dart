part of 'sockets_bloc.dart';


sealed class SocketsEvent extends Equatable {
  const SocketsEvent();

  @override
  List<Object> get props => [];
}

class InitSocket extends SocketsEvent { }

class UpdateServerStatus extends SocketsEvent {
  final ServerStatus serverStatus;

  const UpdateServerStatus({required this.serverStatus});
}

class DisconnectToken extends SocketsEvent {}

class UpdateToken extends SocketsEvent {
  final String token;
  const UpdateToken({required this.token});
}

class ConnectSockets extends SocketsEvent{
}
class UpdateSocketClient extends SocketsEvent {
  final Socket socket;

  const UpdateSocketClient({ required this.socket});
}