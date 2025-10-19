part of 'message_bloc.dart';



final class MessageState extends Equatable {
  
  final ListStatus status;
  final int unreadUserChats;
  // final List<ChatMessage> userMessages;
  final List<ChatMessageWithUser> roomMessages;
  // final List<UserData> users;
  final bool hasReachedMax;

  const MessageState({
    this.status = ListStatus.initial,
    this.unreadUserChats = 0,
    // this.userMessages = const <ChatMessage>[],
    this.roomMessages = const <ChatMessageWithUser>[],
    // this.users = const <UserData>[],
    this.hasReachedMax = false, 
  });


  MessageState copyWith({
    ListStatus? status,
    int? unreadUserChats,
    // List<ChatMessage>? userMessages,
    List<ChatMessageWithUser>? roomMessages,
    // List<UserData>? users,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
      unreadUserChats: unreadUserChats ?? this.unreadUserChats,
      // userMessages: userMessages ?? this.userMessages,
      roomMessages: roomMessages ?? this.roomMessages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      // users: users ?? this.users
    );
  }
  
  @override
  String toString() {
    return '''MessagesState { status: $status, hasReachedMax: $hasReachedMax, messages: ${roomMessages.length} }''';
  }

  
  @override
  List<Object> get props => [status, unreadUserChats, /*userMessages,*/  roomMessages, hasReachedMax /*, users */];
}

final class MessageInitial extends MessageState {}
