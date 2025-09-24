import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_neon_platform_button.dart';
import '../../../models/platform/platform_icon_model.dart';

class MoleculeUserPlatformsButtons extends StatelessWidget {
  const MoleculeUserPlatformsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    final userPlatforms = getUserPlatoforms(userBloc.state);
    return ListView.builder(
      dragStartBehavior: DragStartBehavior.start,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userPlatforms.length,
      itemBuilder: (BuildContext context, int index) {
        return FadeIn(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: AtomNeonPlatformButton(
                platform: userPlatforms[index],
                onTap: () {
                  context.push("/search_game", extra: userPlatforms[index].id);
                },
                sizeMultiplier: 0.6,
              ),
            ),
          ),
        );
      },
    );
  }

  List<PlatformIconModel> getUserPlatoforms(UserState userState) {
    List<PlatformIconModel> platforms = [
      PlatformIconModel(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: userState.platforms.contains(17),
          size: 20, padding: 10),
      PlatformIconModel(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: userState.platforms.contains(15),
          size: 20, padding: 20),
      PlatformIconModel(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: userState.platforms.contains(16),
          size: 20, padding: 20),
      PlatformIconModel(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: userState.platforms.contains(18),
          size: 20, padding: 20),
      PlatformIconModel(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: userState.platforms.contains(187),
          size: 20, padding: 20),
      PlatformIconModel(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: userState.platforms.contains(19),
          size: 20, padding: 20),
      PlatformIconModel(
          id: 9,
          active: userState.platforms.contains(9),
          path: "assets/platforms/nintendo_ds.svg",
          size: 20,
          padding: 20),
      PlatformIconModel(
          id: 8,
          active: userState.platforms.contains(8),
          path: "assets/platforms/nintendo_3ds.svg",
          size: 20,
          padding: 20),
      PlatformIconModel(
          id: 11,
          active: userState.platforms.contains(11),
          path: "assets/platforms/nintendo_wii.svg",
          size: 20,
          padding: 20),
      PlatformIconModel(
          id: 10,
          active: userState.platforms.contains(10),
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20,
          padding: 20),
      PlatformIconModel(
          id: 7,
          active: userState.platforms.contains(7),
          path: "assets/platforms/nintendo_switch.svg",
          size: 20, padding: 20),
      PlatformIconModel(
          id: 14,
          active: userState.platforms.contains(14),
          path: "assets/platforms/xbox_360.svg",
          size: 20, padding: 20),
      PlatformIconModel(
          id: 1,
          active: userState.platforms.contains(1),
          path: "assets/platforms/xbox_one.svg",
          size: 20, padding: 20),
      PlatformIconModel(
          id: 186,
          active: userState.platforms.contains(186),
          path: "assets/platforms/xbox_series.svg",
          size: 20, padding: 20),
      PlatformIconModel(
          id: 4,
          active: userState.platforms.contains(4),
          path: "assets/platforms/pc_2.svg",
          size: 20, padding: 20),
      PlatformIconModel(
          id: 21,
          active: userState.platforms.contains(21),
          path: "assets/platforms/mobile.svg",
          size: 20, padding: 20)
    ];

    // Filter to only include platforms that are active (user has them)
    return platforms.where((platform) => platform.active).toList();
  }

  
}