import 'package:flutter/material.dart';
import 'package:Madnolia/views/platforms_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';

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
