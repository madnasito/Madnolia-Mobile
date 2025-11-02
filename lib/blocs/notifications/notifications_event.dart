part of 'notifications_bloc.dart';

class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}


class LoadNotifications extends NotificationsEvent {
  final bool reload;

  const LoadNotifications({this.reload = false});
}

class WatchNotifications extends NotificationsEvent {}

class DeleteNotification extends NotificationsEvent {
  final String id;

  const DeleteNotification({required this.id});
}