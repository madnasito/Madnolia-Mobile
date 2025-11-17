part of 'chats_bloc.dart';

class ChatsState extends Equatable {

  final ListStatus status;
  final List<UserChatModel> usersChats;
  final bool hasReachedMax;

  const ChatsState({
    this.status = ListStatus.initial,
    this.usersChats = const <UserChatModel>[],
    this.hasReachedMax = false
  });

  ChatsState copyWith({
    ListStatus? status,
    List<UserChatModel>? usersChats,
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
