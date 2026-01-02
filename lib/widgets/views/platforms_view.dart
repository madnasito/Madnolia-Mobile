import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:animate_do/animate_do.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/utils/platforms/platforms_util.dart';
import 'package:madnolia/widgets/atoms/buttons/icon/atom_father_platform_icon.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';

import 'package:madnolia/widgets/platform_icon_widget.dart';


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

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const SizedBox(height: 10),
        FadeIn(
            delay: const Duration(milliseconds: 300),
            child: CenterTitleAtom(text: t.REGISTER.SELECT_PLATFORMS,
            textStyle: neonTitleText,),
            ),
        const SizedBox(height: 20),
        FadeIn(
            delay: const Duration(milliseconds: 500),
            child: CenterTitleAtom(text: t.REGISTER.SELECT_PLATFORMS_SUBTITLE,
            textStyle: neonSubTitleText,),
            ),
        const SizedBox(height: 20),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          alignment: WrapAlignment.spaceAround,
          direction: Axis.horizontal,
          children: [
            ..._fatherToMap(fatherPlatforms),
            ..._toMap(otherItems),
          ],
        ),
        SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          child: FadeIn(
            delay: const Duration(seconds: 1),
            child: Column(
              children: [
                const SizedBox(height: 70),
                ...loadPlatforms(currentFather),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> loadPlatforms(int value) {
    switch (value) {
      case 1:
        return _toMap(nintendoItems);

      case 2:
        return _toMap(playstationItems);

      case 3:
        return _toMap(xboxItems);

      default:
        return [];
    }
  }

  List<Widget> _fatherToMap(List<PlatformIconModel> list) {
    return list
        .map((item) => FadeIn(
            delay: const Duration(milliseconds: 700),
            child: GestureDetector(
              onTap: () async {
                if (currentFather != item.id) {
                  item.active = true;

                  currentFather = item.id;
                } else {
                  item.active = false;
                  currentFather = 0;
                }

                for (var element in fatherPlatforms) {
                  if (element.active && element.id != item.id) {
                    element.active = false;
                  }
                }

                setState(() {});
              },
              child: AtomFatherPlatformIcon(
                platform: item,
              ),
            )))
        .toList();
  }

  List<Widget> _toMap(List<PlatformIconModel> list) {
    return list
        .map((item) => FadeIn(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    String currentRouteName =
                        "/${ModalRoute.of(context)?.settings.name}";
                    if (currentRouteName == "/platforms") {
                      context.push("/platforms/${item.id}");
                      return;
                    }
                    item.active = !item.active;
                    if (item.active) {
                      widget.platforms.add(item.id);
                    } else {
                      int index = widget.platforms
                          .indexWhere((element) => element == item.id);

                      if (index != -1) {
                        widget.platforms.removeAt(index);
                      }
                    }
                  });
                },
                child: PlatformIcon(platform: item))))
        .toList();
  }
}
