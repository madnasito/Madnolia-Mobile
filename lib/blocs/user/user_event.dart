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

class UserUpdateImage extends UserEvent {
  final String thumbImage;
  final String image;

  const UserUpdateImage({required this.thumbImage, required this.image});
}

class UserUpdateChatRoom extends UserEvent {
  final String chatRoom;

  const UserUpdateChatRoom({required this.chatRoom});
}

class AddNotifications extends UserEvent {
  final int value;
  const AddNotifications({required this.value});
}

class RestoreNotifications extends UserEvent {}