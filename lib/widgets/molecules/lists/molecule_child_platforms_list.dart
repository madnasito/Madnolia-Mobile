import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../models/platform/platform_icon_model.dart';
import '../../platform_icon_widget.dart';

class MoleculeChildPlatformsList extends StatelessWidget {
  final List<PlatformIconModel> platforms;
  final Function(PlatformIconModel) onPlatformSelected;

  const MoleculeChildPlatformsList({
    super.key,
    required this.platforms,
    required this.onPlatformSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (platforms.isEmpty) return const SizedBox.shrink();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: platforms.length,
      itemBuilder: (context, index) {
        final item = platforms[index];
        return FadeIn(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onPlatformSelected(item),
            child: PlatformIcon(platform: item),
          ),
        );
      },
    );
  }
}
