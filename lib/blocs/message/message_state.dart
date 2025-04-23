part of 'message_bloc.dart';

enum MessageStatus { initial, success, failure }

final class MessageState extends Equatable {
  
  final MessageStatus status;
  final List<ChatMessage> userMessages;
  final List<ChatMessage> groupMessages;
  final List<UserDb> users;
  final bool hasReachedMax;

  const MessageState({
    this.status = MessageStatus.initial,
    this.userMessages = const <ChatMessage>[],
    this.groupMessages = const <ChatMessage>[],
    this.users = const <UserDb>[],
    this.hasReachedMax = false, 
  });


  MessageState copyWith({
    MessageStatus? status,
    List<ChatMessage>? userMessages,
    List<ChatMessage>? groupMessages,
    List<UserDb>? users,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
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
  List<Object> get props => [status, userMessages, groupMessages, hasReachedMax, users];
}

final class MessageInitial extends MessageState {}
