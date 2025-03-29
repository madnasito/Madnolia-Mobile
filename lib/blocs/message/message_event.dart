part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class UserMessageFetched extends MessageEvent {
  final UserMessagesBody messagesBody;

  const UserMessageFetched({ required this.messagesBody});
}

final class RestoreState extends MessageEvent {}

final class AddIndividualMessage extends MessageEvent {
  final IndividualMessage message;

  const AddIndividualMessage({ required this.message});
}