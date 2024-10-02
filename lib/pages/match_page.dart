import 'package:Madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:Madnolia/models/match/full_match.model.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/blocs/message_provider.dart';
import 'package:Madnolia/views/match_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extraInfo = GoRouterState.of(context).extra!;
    final bloc = MessageProvider.of(context);
    return CustomScaffold(
      body: Background(
        child: SafeArea(
            child: FutureBuilder(
          future: MatchService().getFullMatch(extraInfo.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {


              if (snapshot.data.containsKey("match")) {
                final FullMatch match = FullMatch.fromJson(snapshot.data["match"]);
                
                final respMessages = snapshot.data["messages"];

                final socketBloc = context.watch<SocketsBloc>();

                return MatchChat(
                  match: match,
                  bloc: bloc,
                  matchMessages: respMessages,
                  socketClient: socketBloc.state.clientSocket
                );
              } else {
                return const Center(child: Text("Error loading match."));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )),
      ),
    );
  }
}
