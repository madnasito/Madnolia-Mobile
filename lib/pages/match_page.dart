import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/views/match_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extraInfo = GoRouterState.of(context).extra!;
    final bloc = MessageProvider.of(context);
    final service = FlutterBackgroundService();
    service.invoke("look");
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

                // final socketBloc = context.watch<SocketsBloc>();
                return MatchChat(
                  match: match,
                  bloc: bloc,
                  matchMessages: respMessages,
                  service: FlutterBackgroundService(),
                  // socketClient: socketBloc.state.socketHandler.socket
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
