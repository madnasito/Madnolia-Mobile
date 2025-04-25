import 'package:flutter/material.dart';
import 'package:madnolia/blocs/message/message_bloc.dart' show MessageState;
import 'package:madnolia/widgets/atoms/chat/atom_individual_message.dart' show AtomIndividualMessage;

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
    return ListView.builder(
      shrinkWrap: false,
      addAutomaticKeepAlives: true,
      reverse: true,
      itemBuilder: (context, index) {
        if (index < state.userMessages.length) {
          return AtomIndividualMessage(message: state.userMessages[index]);
        }
        
        // Only show loading indicator at the bottom if we're loading more
        return isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : const SizedBox.shrink();
      },
      itemCount: state.userMessages.length + (isLoading ? 1 : 0),
      controller: scrollController,
    );
  }
}