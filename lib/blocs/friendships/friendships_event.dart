part of 'friendships_bloc.dart';

class FriendshipsEvent extends Equatable {
  const FriendshipsEvent();

  @override
  List<Object> get props => [];
}

class RestoreFriendshipsState extends FriendshipsEvent {}

class LoadFriendships extends FriendshipsEvent {
  final bool reload;
  const LoadFriendships({this.reload = false});
}