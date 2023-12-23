import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/views/create_match_view.dart';
import 'package:Madnolia/views/platforms_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import '../../widgets/platform_icon_widget.dart';

class NewPage extends StatefulWidget {
  NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
  int selectedPlatform = 0;
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    // final searchController = TextEditingController();

    return CustomScaffold(
        body: Background(
            child: widget.selectedPlatform == 0
                ? SingleChildScrollView(
                    child: Column(
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
                        SingleChildScrollView(
                          dragStartBehavior: DragStartBehavior.start,
                          child: FadeIn(
                            delay: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                const SizedBox(height: 70),
                                ..._toMap(),
                                const SizedBox(height: 70),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SearchGameView(platformId: widget.selectedPlatform)));
  }

  List<Widget> _toMap() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<Platform> platforms = [
      Platform(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: userProvider.user.platforms.contains(17) ? true : false,
          size: 20),
      Platform(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: userProvider.user.platforms.contains(15) ? true : false,
          size: 60),
      Platform(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: userProvider.user.platforms.contains(16) ? true : false,
          size: 60),
      Platform(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: userProvider.user.platforms.contains(18) ? true : false,
          size: 60),
      Platform(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: userProvider.user.platforms.contains(187) ? true : false,
          size: 60),
      Platform(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: userProvider.user.platforms.contains(19) ? true : false,
          size: 20),
      Platform(
          id: 4,
          active: userProvider.user.platforms.contains(4) ? true : false,
          path: "assets/platforms/nintendo_ds.svg",
          size: 20),
      Platform(
          id: 8,
          active: userProvider.user.platforms.contains(8) ? true : false,
          path: "assets/platforms/nintendo_3ds.svg",
          size: 20),
      Platform(
          id: 11,
          active: userProvider.user.platforms.contains(11) ? true : false,
          path: "assets/platforms/nintendo_wii.svg",
          size: 20),
      Platform(
          id: 10,
          active: userProvider.user.platforms.contains(10) ? true : false,
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20),
      Platform(
          id: 7,
          active: userProvider.user.platforms.contains(7) ? true : false,
          path: "assets/platforms/nintendo_switch.svg",
          size: 70),
      Platform(
          id: 1,
          active: userProvider.user.platforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 70),
      Platform(
          id: 186,
          active: userProvider.user.platforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 30)
    ];
    return platforms
        .map((item) => FadeIn(
            child: item.active
                ? GestureDetector(
                    onTap: () {
                      widget.selectedPlatform = item.id;
                      setState(() {});
                    },
                    child: PlatformIcon(platform: item))
                : Container()))
        .toList();
  }
}

// class UserPlatformsView extends StatefulWidget {
//   int selectedPlatform;
//   List<int> userPlatforms;
//   UserPlatformsView(
//       {super.key, required this.selectedPlatform, required this.userPlatforms});

//   @override
//   State<UserPlatformsView> createState() => _UserPlatformsViewState();
// }

// class _UserPlatformsViewState extends State<UserPlatformsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         FadeIn(
//             delay: const Duration(milliseconds: 300),
//             child: const Text(
//               "Please, select your platforms",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             )),
//         const SizedBox(height: 40),
//         SingleChildScrollView(
//           dragStartBehavior: DragStartBehavior.start,
//           child: FadeIn(
//             delay: const Duration(seconds: 1),
//             child: Column(
//               children: [
//                 const SizedBox(height: 70),
//                 ..._toMap(),
//                 const SizedBox(height: 70),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   List<Widget> _toMap() {
//     List<Platform> platforms = [
//       Platform(
//           id: 17,
//           path: "assets/platforms/playstation_portable.svg",
//           active: widget.userPlatforms.contains(17) ? true : false,
//           size: 20),
//       Platform(
//           id: 15,
//           path: "assets/platforms/playstation_2.svg",
//           active: widget.userPlatforms.contains(15) ? true : false,
//           size: 60),
//       Platform(
//           id: 16,
//           path: "assets/platforms/playstation_3.svg",
//           active: widget.userPlatforms.contains(16) ? true : false,
//           size: 60),
//       Platform(
//           id: 18,
//           path: "assets/platforms/playstation_4.svg",
//           active: widget.userPlatforms.contains(18) ? true : false,
//           size: 60),
//       Platform(
//           id: 187,
//           path: "assets/platforms/playstation_5.svg",
//           active: widget.userPlatforms.contains(187) ? true : false,
//           size: 60),
//       Platform(
//           id: 19,
//           path: "assets/platforms/playstation_vita.svg",
//           active: widget.userPlatforms.contains(19) ? true : false,
//           size: 20),
//       Platform(
//           id: 4,
//           active: widget.userPlatforms.contains(4) ? true : false,
//           path: "assets/platforms/nintendo_ds.svg",
//           size: 20),
//       Platform(
//           id: 8,
//           active: widget.userPlatforms.contains(8) ? true : false,
//           path: "assets/platforms/nintendo_3ds.svg",
//           size: 20),
//       Platform(
//           id: 11,
//           active: widget.userPlatforms.contains(11) ? true : false,
//           path: "assets/platforms/nintendo_wii.svg",
//           size: 20),
//       Platform(
//           id: 10,
//           active: widget.userPlatforms.contains(10) ? true : false,
//           path: "assets/platforms/nintendo_wiiu.svg",
//           size: 20),
//       Platform(
//           id: 7,
//           active: widget.userPlatforms.contains(7) ? true : false,
//           path: "assets/platforms/nintendo_switch.svg",
//           size: 70),
//       Platform(
//           id: 1,
//           active: widget.userPlatforms.contains(1) ? true : false,
//           path: "assets/platforms/xbox_one.svg",
//           size: 70),
//       Platform(
//           id: 186,
//           active: widget.userPlatforms.contains(186) ? true : false,
//           path: "assets/platforms/xbox_series.svg",
//           size: 30)
//     ];
//     return platforms
//         .map((item) => FadeIn(
//             child: item.active
//                 ? GestureDetector(
//                     onTap: () {
//                       widget.selectedPlatform = item.id;
//                       setState(() {});
//                     },
//                     child: PlatformIcon(platform: item))
//                 : Container()))
//         .toList();
//   }
// }
