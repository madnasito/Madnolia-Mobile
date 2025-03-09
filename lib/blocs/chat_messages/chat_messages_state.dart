part of 'chat_messages_bloc.dart';

class ChatMessagesState extends Equatable {
  final List<ChatMessageOrganism> chatMessages;
  final bool isLoadingMessages;
  const ChatMessagesState({this.chatMessages = const [], this.isLoadingMessages = false });
  
  ChatMessagesState copyWith({
    List<ChatMessageOrganism>? chatMessages,
    bool? isLoadingMessages
  }) => ChatMessagesState(
    chatMessages: chatMessages ?? this.chatMessages,
    isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages
  );

  @override
  List<Object> get props => [chatMessages, isLoadingMessages];
}


