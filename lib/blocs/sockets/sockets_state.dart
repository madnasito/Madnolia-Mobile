part of 'sockets_bloc.dart';

sealed class SocketsState extends Equatable {
  const SocketsState();
  
  @override
  List<Object> get props => [];
}

final class SocketsInitial extends SocketsState {}
