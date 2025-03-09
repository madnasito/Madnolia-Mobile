// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:madnolia/services/messages_service.dart';

// import '../../blocs/chat_messages/chat_messages_bloc.dart';
// import '../../models/chat/message_model.dart';
// import 'chat_message_organism.dart';

// class ChatOrganism extends StatelessWidget {
//   final String match;
//   const ChatOrganism({super.key, required this.match});

//   @override
//   Widget build(BuildContext context) {
//     int page = 0;
//     bool loadingNewMessages = false;

//     return FutureBuilder(
//         future: MessagesService().getMatchMessages(match, page),
//         builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
//           if (snapshot.hasData) {
//             String lastUser = "";
//             final chatMessagesBloc = context.watch<ChatMessagesBloc>();
//             List<ChatMessageOrganism> messages = snapshot.data!.map((e) {
//               final isTheSame = e.user.id == lastUser ? false : true;
//               lastUser = e.user.id;
//               return ChatMessageOrganism(
//                   text: e.text, user: e.user, mainMessage: isTheSame);
//             }).toList();

//             chatMessagesBloc.pushMessages(messages);
//             final scrollController = ScrollController();
//             scrollController.addListener(() async {
//               print(scrollController.position.pixels);
//               print(scrollController.position.maxScrollExtent);
//               if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
//                   !chatMessagesBloc.state.isLoadingMessages) {
//                 try {
//                   chatMessagesBloc.isLoading(true);

//                   final resp =
//                       await MessagesService().getMatchMessages(match, page);
//                   List<ChatMessageOrganism> newMessages = resp.map((e) {
//                     final isTheSame = e.user.id == lastUser ? false : true;
//                     lastUser = e.user.id;
//                     return ChatMessageOrganism(
//                         text: e.text, user: e.user, mainMessage: isTheSame);
//                   }).toList();

//                   // messages.addAll(newMessages);
//                   chatMessagesBloc.pushMessages(newMessages);
//                   page++;
//                   // loadingNewMessages = false;
//                   chatMessagesBloc.isLoading(false);
//                 } catch (e) {
//                   chatMessagesBloc.isLoading(false);
//                 }
//               }
//             });
//             return Flexible(
//                 child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
//               color: Colors.black38,
//               child: BlocBuilder<ChatMessagesBloc, ChatMessagesState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                   controller: scrollController,
//                   reverse: true,
//                   itemCount: state.chatMessages.length,
//                   itemBuilder: (_, i) => state.chatMessages[i]);
//                 },
//               ),
              
//             ));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }
// }
