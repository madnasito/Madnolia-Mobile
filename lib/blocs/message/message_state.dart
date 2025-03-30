part of 'message_bloc.dart';

enum MessageStatus { initial, success, failure }

final class MessageState extends Equatable {
  
  final MessageStatus status;
  final List<IndividualMessage> userMessages;
  final List<GroupMessage> groupMessages;
  final bool hasReachedMax;

  const MessageState({
    this.status = MessageStatus.initial,
    this.userMessages = const <IndividualMessage>[],
    this.groupMessages = const <GroupMessage>[],
    this.hasReachedMax = false, 
  });


  MessageState copyWith({
    MessageStatus? status,
    List<IndividualMessage>? userMessages,
    List<GroupMessage>? groupMessages,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
      userMessages: userMessages ?? this.userMessages,
      groupMessages: groupMessages ?? this.groupMessages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  
  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${userMessages.length} }''';
  }

  
  @override
  List<Object> get props => [status, userMessages, groupMessages, hasReachedMax];
}

final class MessageInitial extends MessageState {}
