part of 'chats_bloc.dart';

class ChatsState extends Equatable {

  final ListStatus status;
  final List<UserChat> usersChats;
  final bool hasReachedMax;

  const ChatsState({
    this.status = ListStatus.initial,
    this.usersChats = const <UserChat>[],
    this.hasReachedMax = false
  });

  ChatsState copyWith({
    ListStatus? status,
    List<UserChat>? usersChats,
    bool? hasReachedMax
  }){
    return ChatsState(
      status: status ?? this.status,
      usersChats: usersChats ?? this.usersChats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  
  @override
  List<Object> get props => [usersChats, status, hasReachedMax];
}

final class ChatsInitial extends ChatsState {}
