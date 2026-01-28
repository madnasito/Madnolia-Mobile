import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/utils/platforms/platforms_util.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';

import 'package:madnolia/widgets/molecules/lists/molecule_child_platforms_list.dart';
import 'package:madnolia/widgets/molecules/lists/molecule_father_platforms_selector.dart';

class PlatformsView extends StatefulWidget {
  final List<int> platforms;
  const PlatformsView({super.key, required this.platforms});

  @override
  State<PlatformsView> createState() => _PlatformsViewState();
}

class _PlatformsViewState extends State<PlatformsView> {
  int currentFather = 0;
  List<PlatformIconModel> fatherPlatforms = getFatherPlatforms();
  late List<PlatformIconModel> playstationItems;
  late List<PlatformIconModel> nintendoItems;
  late List<PlatformIconModel> xboxItems;
  late List<PlatformIconModel> otherItems;

  @override
  void initState() {
    playstationItems = getPlaystationChildren(widget.platforms);
    nintendoItems = getNintendoChildren(widget.platforms);
    xboxItems = getXboxChildren(widget.platforms);
    otherItems = getOthersPlatforms(widget.platforms);
    super.initState();
  }

  @override
  void dispose() {
    currentFather = 0;
    super.dispose();
  }

  List<PlatformIconModel> _getCurrentChildList() {
    switch (currentFather) {
      case 1:
        return nintendoItems;
      case 2:
        return playstationItems;
      case 3:
        return xboxItems;
      default:
        return [];
    }
  }

  void _handleFatherSelection(int fatherId) {
    setState(() {
      if (currentFather == fatherId) {
        currentFather = 0;
        for (var p in fatherPlatforms) {
          p.active = false;
        }
      } else {
        currentFather = fatherId;
        for (var p in fatherPlatforms) {
          p.active = (p.id == fatherId);
        }
      }
    });
  }

  void _handlePlatformSelection(PlatformIconModel item) {
    final String currentRouteName = "/${ModalRoute.of(context)?.settings.name}";
    if (currentRouteName == "/platforms") {
      context.push("/platforms/${item.id}");
      return;
    }

    setState(() {
      item.active = !item.active;
      if (item.active) {
        if (!widget.platforms.contains(item.id)) {
          widget.platforms.add(item.id);
        }
      } else {
        widget.platforms.remove(item.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        FadeIn(
          delay: const Duration(milliseconds: 300),
          child: CenterTitleAtom(
            text: t.REGISTER.SELECT_PLATFORMS,
            textStyle: neonTitleText,
          ),
        ),
        const SizedBox(height: 20),
        FadeIn(
          delay: const Duration(milliseconds: 500),
          child: CenterTitleAtom(
            text: t.REGISTER.SELECT_PLATFORMS_SUBTITLE,
            textStyle: neonSubTitleText,
          ),
        ),
        const SizedBox(height: 20),
        MoleculeFatherPlatformsSelector(
          fatherPlatforms: fatherPlatforms,
          otherItems: otherItems,
          currentFather: currentFather,
          onFatherSelected: _handleFatherSelection,
          onOtherSelected: _handlePlatformSelection,
        ),
        const SizedBox(height: 70),
        MoleculeChildPlatformsList(
          platforms: _getCurrentChildList(),
          onPlatformSelected: _handlePlatformSelection,
        ),
      ],
    );
  }
}
