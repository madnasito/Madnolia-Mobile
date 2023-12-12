import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';

import 'package:madnolia/widgets/platform_icon_widget.dart';

int currentFather = 0;

class PlatformsView extends StatefulWidget {
  final List platforms;
  PlatformsView({super.key, required this.platforms});

  @override
  State<PlatformsView> createState() => _PlatformsViewState();

  List<Platform> fatherPlatforms = [
    Platform(
        id: 1,
        path: "assets/platforms/nintendo.svg",
        active: false,
        size: 25,
        background: const Color(0xffed1c24)),
    Platform(
        id: 2,
        path: "assets/platforms/playstation.svg",
        active: false,
        size: 25,
        background: Colors.blue),
    Platform(
        id: 3,
        path: "assets/platforms/xbox.svg",
        active: false,
        size: 25,
        background: Colors.green),
  ];

  List<Platform> playstationItems = [];

  List<Platform> nintendoItems = [];

  List<Platform> xboxItems = [];
}

class _PlatformsViewState extends State<PlatformsView> {
  @override
  void initState() {
    widget.playstationItems = [
      Platform(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: widget.platforms.contains(17) ? true : false,
          size: 20),
      Platform(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: widget.platforms.contains(15) ? true : false,
          size: 60),
      Platform(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: widget.platforms.contains(16) ? true : false,
          size: 60),
      Platform(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: widget.platforms.contains(18) ? true : false,
          size: 60),
      Platform(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: widget.platforms.contains(187) ? true : false,
          size: 60),
      Platform(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: widget.platforms.contains(19) ? true : false,
          size: 20),
    ];

    widget.nintendoItems = [
      Platform(
          id: 4,
          active: widget.platforms.contains(4) ? true : false,
          path: "assets/platforms/nintendo_ds.svg",
          size: 20),
      Platform(
          id: 8,
          active: widget.platforms.contains(8) ? true : false,
          path: "assets/platforms/nintendo_3ds.svg",
          size: 20),
      Platform(
          id: 11,
          active: widget.platforms.contains(11) ? true : false,
          path: "assets/platforms/nintendo_wii.svg",
          size: 20),
      Platform(
          id: 10,
          active: widget.platforms.contains(10) ? true : false,
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20),
      Platform(
          id: 7,
          active: widget.platforms.contains(7) ? true : false,
          path: "assets/platforms/nintendo_switch.svg",
          size: 70)
    ];

    widget.xboxItems = [
      // Platform(active: false, path: "assets/platforms/xbox_360.svg", size: 70),
      Platform(
          id: 1,
          active: widget.platforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 70),
      Platform(
          id: 186,
          active: widget.platforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 30)
    ];
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
        const SizedBox(height: 20),
        FadeIn(
            delay: const Duration(milliseconds: 300),
            child: const Text(
              "Please, select your platforms",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            )),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [..._fatherToMap(widget.fatherPlatforms)],
        ),
        SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          child: FadeIn(
            delay: const Duration(seconds: 1),
            child: Column(
              children: [
                const SizedBox(height: 70),
                ...loadPlatforms(currentFather),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> loadPlatforms(value) {
    switch (value) {
      case 1:
        return _toMap(widget.nintendoItems);

      case 2:
        return _toMap(widget.playstationItems);

      case 3:
        return _toMap(widget.xboxItems);

      default:
        return [];
    }
  }

  List<Widget> _fatherToMap(List<Platform> list) {
    return list
        .map((item) => FadeIn(
            delay: const Duration(milliseconds: 700),
            child: GestureDetector(
              onTap: () async {
                item.active = true;

                currentFather = item.id;

                for (var element in widget.fatherPlatforms) {
                  if (element.active && element.id != item.id) {
                    element.active = false;
                  }
                }

                setState(() {});
              },
              child: FatherPlatformIcon(
                platform: item,
              ),
            )))
        .toList();
  }

  List<Widget> _toMap(List<Platform> list) {
    return list
        .map((item) => FadeIn(
            child: GestureDetector(
                onTap: () {
                  setState(() {
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

class FatherPlatformIcon extends StatefulWidget {
  final Platform platform;

  const FatherPlatformIcon({
    super.key,
    required this.platform,
  });

  @override
  State<FatherPlatformIcon> createState() => _FatherPlatformIcon();
}

class _FatherPlatformIcon extends State<FatherPlatformIcon> {
  @override
  Widget build(BuildContext context) {
    final iconSize =
        (widget.platform.size * MediaQuery.of(context).size.width) / 100;
    return Container(
      padding: const EdgeInsets.all(2),
      width: iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
            color: Colors.black,
            width: 2,
            style:
                widget.platform.active ? BorderStyle.solid : BorderStyle.none),
        color: widget.platform.active
            ? widget.platform.background
            : Colors.transparent,
      ),
      child: SvgPicture.asset(
        widget.platform.path,
        height: iconSize,
        width: iconSize,
        color: (widget.platform.active)
            ? Colors.white
            : const Color.fromARGB(172, 109, 109, 109),
      ),
    );
  }
}
