part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotificationDetails> data;
  final bool hasReachedMax;
  final BlocStatus status;

  const NotificationsState({
    this.data = const <NotificationDetails>[],
    this.hasReachedMax = false,
    this.status = BlocStatus.initial
  });

  NotificationsState copyWith({
    List<NotificationDetails>? data,
    bool? hasReachedMax,
    BlocStatus? status
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

