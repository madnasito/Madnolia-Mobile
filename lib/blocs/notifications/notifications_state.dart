part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationDetails> data;
  final bool hasReachedMax;
  final BlocStatus status;
  final int unreadCount;

  const NotificationsState({
    this.data = const <NotificationDetails>[],
    this.hasReachedMax = false,
    this.status = BlocStatus.initial,
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    List<NotificationDetails>? data,
    bool? hasReachedMax,
    BlocStatus? status,
    int? unreadCount,
  }) {
    return NotificationsState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object> get props => [data, hasReachedMax, status, unreadCount];
}
