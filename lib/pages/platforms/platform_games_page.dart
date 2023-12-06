import 'package:flutter/material.dart';

import 'package:madnolia/services/rawg_service.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class PlatformGames extends StatelessWidget {
  final String id;
  const PlatformGames({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Background(
      child: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: RawgService().getPlatformGames(id: id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GameCard(
                          game: snapshot.data[index], bottom: const Text(""));
                    });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    ));
  }
}
