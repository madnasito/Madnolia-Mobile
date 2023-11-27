import 'package:flutter/material.dart';
import 'package:madnolia/views/create_match_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return CustomScaffold(
        body: Background(
            child: SearchGameView(
      controller: searchController,
    )));
  }
}
