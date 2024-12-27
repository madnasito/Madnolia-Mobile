import 'package:flutter/material.dart';
import 'package:madnolia/views/platforms_view.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class PlatformsPage extends StatelessWidget {
  const PlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: SingleChildScrollView(child: PlatformsView(platforms: [])),
    );
  }
}
