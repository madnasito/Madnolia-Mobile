import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../models/platform/platform_icon_model.dart';
import '../../atoms/buttons/icon/atom_father_platform_icon.dart';
import '../../platform_icon_widget.dart';

class MoleculeFatherPlatformsSelector extends StatelessWidget {
  final List<PlatformIconModel> fatherPlatforms;
  final List<PlatformIconModel> otherItems;
  final int currentFather;
  final Function(int) onFatherSelected;
  final Function(PlatformIconModel) onOtherSelected;

  const MoleculeFatherPlatformsSelector({
    super.key,
    required this.fatherPlatforms,
    required this.otherItems,
    required this.currentFather,
    required this.onFatherSelected,
    required this.onOtherSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      alignment: WrapAlignment.spaceAround,
      direction: Axis.horizontal,
      children: [
        ...fatherPlatforms.map((item) {
          return FadeIn(
            delay: const Duration(milliseconds: 700),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onFatherSelected(item.id),
              child: AtomFatherPlatformIcon(platform: item),
            ),
          );
        }),
        ...otherItems.map((item) {
          return FadeIn(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onOtherSelected(item),
              child: PlatformIcon(platform: item),
            ),
          );
        }),
      ],
    );
  }
}
