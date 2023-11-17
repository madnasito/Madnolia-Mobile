import 'package:flutter/material.dart';
import 'package:madnolia/views/create_match_view.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(body: CreateMatchView());
  }
}
