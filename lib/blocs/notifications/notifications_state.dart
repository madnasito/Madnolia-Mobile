part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationData> data;
  final bool hasReachedMax;
  final ListStatus status;

  const NotificationsState({
    this.data = const <NotificationData>[],
    this.hasReachedMax = false,
    this.status = ListStatus.initial
  });

  NotificationsState copyWith({
    List<NotificationData>? data,
    bool? hasReachedMax,
    ListStatus? status
  }) {
    return NotificationsState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [data, hasReachedMax, status];
}

