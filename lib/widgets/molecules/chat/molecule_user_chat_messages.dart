import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/widgets/atoms/chat/atom_my_individual_message.dart';
import 'package:madnolia/widgets/atoms/chat/atom_not_my_individual_message.dart';

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
          return state.roomMessages[index].chatMessage.creator == myUserId 
          ? AtomMyIndividualMessage(message: state.roomMessages[index].chatMessage)
          : AtomNotMyIndividualMessage(message: state.roomMessages[index].chatMessage);
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