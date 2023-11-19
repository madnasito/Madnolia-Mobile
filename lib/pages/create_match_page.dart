import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madnolia/views/create_match_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import '../services/rawg_service.dart';

class NewPage extends StatelessWidget {
  NewPage({super.key});

  var games;
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    int counter = 0;
    return CustomScaffold(
        body: Background(
            child: SearchGameView(
      controller: searchController,
    )));
  }
}
