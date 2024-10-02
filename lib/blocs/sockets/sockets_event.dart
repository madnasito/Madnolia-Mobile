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

class UpdatedToken extends SocketsEvent {}