// import 'package:flutter/material.dart';
// import 'package:flutter_mentions/flutter_mentions.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:madnolia/blocs/message_bloc.dart';
// import 'package:madnolia/database/database.dart';
// import 'package:madnolia/services/match_service.dart';
// import 'package:madnolia/widgets/form_button.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../chat/input_widget.dart';

// class MoleculeMatchChatInput extends StatelessWidget {
//   final String matchOwner;
//   final String userId;
//   final MatchData match;
//   final bool isInMatch;
//   final Socket socketClient;
//   final GlobalKey<FlutterMentionsState> messageKey;
//   final MessageInputBloc bloc;
//   const MoleculeMatchChatInput({
//     super.key,
//     required this.matchOwner,
//     required this.userId,
//     required this.match,
//     required this.isInMatch, required this.socketClient, required this.messageKey, required this.bloc
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool owner = userId == matchOwner ? true : false;

//     List<String> founded =
//         match.joined.where((e) => userId == e).toList();
    
//     if(owner || founded.isNotEmpty || isInMatch){
//       Size screenSize = MediaQuery.of(context).size;

//       double screenWidth = screenSize.width;

//       return Wrap(
//         children: [
//           Container(
//             width: screenWidth * 0.8,
//             margin: const EdgeInsets.only(right: 8),
//             child: InputGroupMessage(
//               inputKey: messageKey,
//               usersList: match.joined,
//               stream: bloc.messageStream,
//               placeholder: "Message",
//               onChanged: bloc.changeMessage,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             child: ElevatedButton(
//               onPressed: () {
//                 _handleSubmit(bloc.message);
//                 bloc.changeMessage("");
//                 messageKey.currentState?.controller?.clear();
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shape: const StadiumBorder(),
//                   side: const BorderSide(
//                     color: Color.fromARGB(255, 65, 169, 255),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
//               child: const Icon(Icons.send_outlined),
//             ),
//           ),
//           // ElevatedButton.icon(
//           //     onPressed: () {}, icon: Icon(Icons.abc), label: Text(""))
//         ],
//       );
//     }else{
//       return FormButton(
//           text: translate("MATCH.JOIN_TO_MATCH"),
//           color: Colors.transparent,
//           onPressed: () async {
//             try {
//               final resp = await MatchService().join(match.id);
//               debugPrint(resp.toString());
//               // match.joined.add(userId)l

//             } catch (e) {
//               debugPrint(e.toString());
//             }
//           });
//     }
//   }

//   void _handleSubmit(String text) {
//     if (text.isEmpty) return;
//     socketClient.emit("message", {"text": text, "conversation": match.id, "type": 2});
//   }
// }