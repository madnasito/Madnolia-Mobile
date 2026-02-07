import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/widgets/atoms/chat/atom_my_individual_message.dart';
import 'package:madnolia/widgets/atoms/chat/atom_not_my_individual_message.dart';
import 'package:madnolia/widgets/atoms/chat/atom_date_header.dart';

class MoleculeUserChatMessagesList extends StatelessWidget {
  final MessageState state;
  final ScrollController scrollController;
  final bool isLoading;

  const MoleculeUserChatMessagesList({
    super.key,
    required this.state,
    required this.scrollController,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final String myUserId = context.read<UserBloc>().state.id;

    return ListView.builder(
      cacheExtent: 9999,
      addAutomaticKeepAlives: true,
      reverse: true,
      itemBuilder: (context, index) {
        if (index < state.roomMessages.length) {
          final currentMessage = state.roomMessages[index].chatMessage;
          bool mainMessage = false;

          if (index == 0) {
            mainMessage = true;
          } else {
            final previousMessage = state.roomMessages[index - 1].chatMessage;
            if (previousMessage.creator != currentMessage.creator) {
              mainMessage = true;
            }
          }

          bool showDateHeader = false;
          if (index == state.roomMessages.length - 1) {
            showDateHeader = true;
          } else {
            final nextMessage = state.roomMessages[index + 1].chatMessage;
            if (currentMessage.date.day != nextMessage.date.day ||
                currentMessage.date.month != nextMessage.date.month ||
                currentMessage.date.year != nextMessage.date.year) {
              showDateHeader = true;
            }
          }

          final messageWidget = currentMessage.creator == myUserId
              ? AtomMyIndividualMessage(
                  message: currentMessage,
                  mainMessage: mainMessage,
                )
              : AtomNotMyIndividualMessage(
                  message: currentMessage,
                  mainMessage: mainMessage,
                );

          if (showDateHeader) {
            return Column(
              children: [
                AtomDateHeader(date: currentMessage.date),
                messageWidget,
              ],
            );
          }
          return messageWidget;
        }

        // Only show loading indicator at the bottom if we're loading more
        return isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : const SizedBox.shrink();
      },
      itemCount: state.roomMessages.length + (isLoading ? 1 : 0),
      controller: scrollController,
    );
  }
}
