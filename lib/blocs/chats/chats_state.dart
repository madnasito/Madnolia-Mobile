part of 'chats_bloc.dart';

class ChatsState extends Equatable {
  final BlocStatus status;
  final List<UserChat> usersChats;
  final bool hasReachedMax;
  final int unreadCount;

  const ChatsState({
    this.status = BlocStatus.initial,
    this.usersChats = const <UserChat>[],
    this.hasReachedMax = false,
    this.unreadCount = 0,
  });

  ChatsState copyWith({
    BlocStatus? status,
    List<UserChat>? usersChats,
    bool? hasReachedMax,
    int? unreadCount,
  }) {
    return ChatsState(
      status: status ?? this.status,
      usersChats: usersChats ?? this.usersChats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object> get props => [usersChats, status, hasReachedMax, unreadCount];
}

final class ChatsInitial extends ChatsState {}
