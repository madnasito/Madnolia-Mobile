part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetInfo extends UserEvent {}

class UpdateData extends UserEvent {
  final User user;
  const UpdateData({required this.user});
}

class UserLogOut extends UserEvent {}

class UpdateImages extends UserEvent {
  final String thumbImage;
  final String image;

  const UpdateImages({required this.thumbImage, required this.image});
}

class UpdateChatRoom extends UserEvent {
  final String chatRoom;

  const UpdateChatRoom({required this.chatRoom});
}

class UpdateAvailability extends UserEvent {
  final UserAvailability availability;
  const UpdateAvailability({required this.availability});
}
