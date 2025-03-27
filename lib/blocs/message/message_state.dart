part of 'message_bloc.dart';

enum MessageStatus { initial, success, failure }

final class MessageState extends Equatable {
  
  final MessageStatus status;
  final List<Message> messages;
  final bool hasReachedMax;

  const MessageState({
    this.status = MessageStatus.initial,
    this.messages = const <Message>[],
    this.hasReachedMax = false, 
  });


  MessageState copyWith({
    MessageStatus? status,
    List<Message>? messages,
    bool? hasReachedMax,
  }) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  
  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${messages.length} }''';
  }

  
  @override
  List<Object> get props => [status, messages, hasReachedMax];
}

final class MessageInitial extends MessageState {}
