import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_neon_platform_button.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';

class MoleculeUserPlatformsButtons extends StatelessWidget {
  const MoleculeUserPlatformsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final userPlatformsIds = context.select(
      (UserBloc bloc) => bloc.state.platforms,
    );
    final userPlatforms = getUserPlatforms(userPlatformsIds);

    return Column(
      children: userPlatforms.map((platform) {
        return FadeIn(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: AtomNeonPlatformButton(
                platform: platform,
                onTap: () {
                  context.push("/search-game", extra: platform.id);
                },
                sizeMultiplier: 0.6,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  List<PlatformIconModel> getUserPlatforms(List<int> userPlatformsIds) {
    final allPlatforms = [
      PlatformIconModel(
        id: 17,
        path: "assets/platforms/playstation_portable.svg",
        active: false,
        size: 20,
        padding: 10,
      ),
      PlatformIconModel(
        id: 15,
        path: "assets/platforms/playstation_2.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 16,
        path: "assets/platforms/playstation_3.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 18,
        path: "assets/platforms/playstation_4.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 187,
        path: "assets/platforms/playstation_5.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 19,
        path: "assets/platforms/playstation_vita.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 9,
        path: "assets/platforms/nintendo_ds.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 8,
        path: "assets/platforms/nintendo_3ds.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 11,
        path: "assets/platforms/nintendo_wii.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 10,
        path: "assets/platforms/nintendo_wiiu.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 7,
        path: "assets/platforms/nintendo_switch.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 14,
        path: "assets/platforms/xbox_360.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 1,
        path: "assets/platforms/xbox_one.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 186,
        path: "assets/platforms/xbox_series.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 4,
        path: "assets/platforms/pc_2.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
      PlatformIconModel(
        id: 21,
        path: "assets/platforms/mobile.svg",
        active: false,
        size: 20,
        padding: 20,
      ),
    ];

    return allPlatforms
        .where((p) => userPlatformsIds.contains(p.id))
        .map((p) => p.copyWith(active: true))
        .toList();
  }
}
