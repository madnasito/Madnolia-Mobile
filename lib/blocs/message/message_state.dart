part of 'message_bloc.dart';



final class MessageState extends Equatable {
  
  final ListStatus status;
  final int unreadUserChats;
  final List<ChatMessage> userMessages;
  final List<ChatMessage> groupMessages;
  final List<UserDb> users;
  final bool hasReachedMax;

  const MessageState({
    this.status = ListStatus.initial,
    this.unreadUserChats = 0,
    this.userMessages = const <ChatMessage>[],
    this.groupMessages = const <ChatMessage>[],
    this.users = const <UserDb>[],
    this.hasReachedMax = false, 
  });


  MessageState copyWith({
    ListStatus? status,
    int? unreadUserChats,
    List<ChatMessage>? userMessages,
    List<ChatMessage>? groupMessages,
    List<UserDb>? users,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
      unreadUserChats: unreadUserChats ?? this.unreadUserChats,
      userMessages: userMessages ?? this.userMessages,
      groupMessages: groupMessages ?? this.groupMessages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      users: users ?? this.users
    );
  }
  
  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${userMessages.length} }''';
  }

  
  @override
  List<Object> get props => [status, unreadUserChats, userMessages, groupMessages, hasReachedMax, users];
}

final class MessageInitial extends MessageState {}
