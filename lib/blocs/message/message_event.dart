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

final class MessageFetched extends MessageEvent {
  final String roomId;
  final ChatMessageType type;

  const MessageFetched({ required this.roomId, required this.type });
}

final class WatchRoomMessages extends MessageEvent {
  final String roomId;

  const WatchRoomMessages({ required this.roomId });
}

final class RestoreState extends MessageEvent {}

final class AddIndividualMessage extends MessageEvent {
  final ChatMessageData message;

  const AddIndividualMessage({ required this.message});
}

final class AddRoomMessage extends MessageEvent {
  final ChatMessageData message;
  const AddRoomMessage({ required this.message });
}

final class AddUser extends MessageEvent {
  final String userId;
  const AddUser( { required this.userId });
}

final class UpdateUnreadUserChatCount extends MessageEvent {
  final int value;
  const UpdateUnreadUserChatCount({required this.value});
}
