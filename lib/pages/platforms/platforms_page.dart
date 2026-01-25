import 'package:flutter/material.dart';
import 'package:madnolia/widgets/views/platforms_view.dart';

class PlatformsPage extends StatelessWidget {
  const PlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: PlatformsView(platforms: []));
  }
}
