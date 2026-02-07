part of 'message_bloc.dart';

final class MessageState extends Equatable {
  final BlocStatus status;
  final int unreadUserChats;
  // final List<ChatMessage> userMessages;
  final List<ChatMessageWithUser> roomMessages;
  // final List<UserData> users;
  final int limit;
  final bool hasReachedMax;

  const MessageState({
    this.status = BlocStatus.initial,
    this.unreadUserChats = 0,
    // this.userMessages = const <ChatMessage>[],
    this.roomMessages = const <ChatMessageWithUser>[],
    // this.users = const <UserData>[],
    this.limit = 50,
    this.hasReachedMax = false,
  });

  MessageState copyWith({
    BlocStatus? status,
    int? unreadUserChats,
    // List<ChatMessage>? userMessages,
    List<ChatMessageWithUser>? roomMessages,
    // List<UserData>? users,
    int? limit,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
      unreadUserChats: unreadUserChats ?? this.unreadUserChats,
      // userMessages: userMessages ?? this.userMessages,
      roomMessages: roomMessages ?? this.roomMessages,
      limit: limit ?? this.limit,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      // users: users ?? this.users
    );
  }

  @override
  String toString() {
    return '''MessagesState { status: $status, hasReachedMax: $hasReachedMax, messages: ${roomMessages.length} }''';
  }

  @override
  List<Object> get props => [
    status,
    unreadUserChats,
    /*userMessages,*/ roomMessages,
    limit,
    hasReachedMax /*, users */,
  ];
}

final class MessageInitial extends MessageState {}
