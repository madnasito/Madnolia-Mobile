part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationData> data;
  final bool hasReachedMax;
  final bool loaded;

  const NotificationsState({
    this.data = const <NotificationData>[],
    this.hasReachedMax = false,
    this.loaded = false
  });

  NotificationsState copyWith({
    List<NotificationData>? data,
    bool? hasReachedMax,
    bool? loaded
  }) {
    return NotificationsState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loaded: loaded ?? this.loaded
    );
  }
  
  @override
  List<Object> get props => [data, hasReachedMax, loaded];
}

