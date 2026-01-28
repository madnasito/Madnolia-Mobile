part of 'chats_bloc.dart';

class ChatsState extends Equatable {

  final BlocStatus status;
  final List<UserChat> usersChats;
  final bool hasReachedMax;

  const ChatsState({
    this.status = BlocStatus.initial,
    this.usersChats = const <UserChat>[],
    this.hasReachedMax = false
  });

  ChatsState copyWith({
    BlocStatus? status,
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
