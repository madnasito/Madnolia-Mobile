part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoadInfo extends UserEvent {
  final User userModel;
  const UserLoadInfo({required this.userModel});
}

class UserLogOut extends UserEvent {}

class UserUpdateImg extends UserEvent {
  final String thumbImg;
  final String img;

  const UserUpdateImg({required this.thumbImg, required this.img});
}

class UserUpdateChatRoom extends UserEvent {
  final String chatRoom;

  const UserUpdateChatRoom({required this.chatRoom});
}