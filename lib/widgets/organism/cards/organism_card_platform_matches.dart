import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/models/platform/platform_games_model.dart';
import 'package:madnolia/utils/platforms.dart' show getPlatformInfo;
import 'package:madnolia/widgets/atoms/ads/atom_banner_ad.dart';
import 'package:madnolia/widgets/molecules/molecule_platform_matches.dart';

class OrganismCardPlatformMatches extends StatelessWidget {
  final PlatformGamesModel platformGames;

  const OrganismCardPlatformMatches({super.key, required this.platformGames});

  @override
  Widget build(BuildContext context) {
    if(platformGames.games.isEmpty) return SizedBox();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black45
      ),
      child: Column(
        children: [
          kDebugMode ? SizedBox() : const AtomBannerAd(),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 20,
            children: [
              Text(getPlatformInfo(platformGames.platform).name),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  getPlatformInfo(platformGames.platform).path,
                  width: 90,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          MoleculePlatformMatches(platform: platformGames.platform)
        ]
      ),
    );
  }
}