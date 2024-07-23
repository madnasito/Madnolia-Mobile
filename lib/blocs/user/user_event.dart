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