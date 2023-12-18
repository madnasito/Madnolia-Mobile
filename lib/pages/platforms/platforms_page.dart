import 'package:flutter/material.dart';
import 'package:madnolia/views/platforms_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class PlatformsPage extends StatelessWidget {
  const PlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Background(
          child:
              SingleChildScrollView(child: PlatformsView(platforms: const []))),
    );
  }
}
