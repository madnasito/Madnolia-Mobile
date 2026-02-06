import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/models/platform/platform_games_model.dart';

import '../../models/game/platform_game.dart';
import '../match_card_widget.dart';

class MoleculePlatformMatches extends StatelessWidget {
  final int platform;

  const MoleculePlatformMatches({required this.platform, super.key});

  @override
  Widget build(BuildContext context) {
    final platformsGamesBloc = context.watch<PlatformGamesBloc>();

    final platformIndex = platformsGamesBloc.state.platformGames.indexWhere(
      (e) => e.platform == platform,
    );

    if (platformIndex == -1) return Container();

    PlatformGamesModel platformState = platformsGamesBloc.state.platformGames
        .elementAt(platformIndex);

    if (platformState.status == PlatformGamesStatus.initial) {
      // platformsGamesBloc.add(PlatformGamesFetched(platformId: platform));
      return CircularProgressIndicator.adaptive();
    } else if (platformState.status == PlatformGamesStatus.success) {
      if (platformState.games.isNotEmpty) {
        CarouselSliderController gamesCarouselController =
            CarouselSliderController();
        return CarouselSlider.builder(
          itemCount: platformState.games.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final PlatformGame game = platformState.games[index];
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  "/platform/$platform/${platformState.games[index].id}",
                  //  extra: {
                  //   "platform": platform,
                  //   "game": platformState.games[index].id
                  // }
                );
              },
              child: GameCard(
                name: game.name,
                background: game.background,
                bottom: Text(_getMatchesTranslation(game.count)),
              ),
            );
          },
          carouselController: gamesCarouselController,
          options: CarouselOptions(
            enableInfiniteScroll: platformState.hasReachedMax,
            aspectRatio: 1.262,
            enlargeFactor: 0.2,
            viewportFraction: 0.9,
            disableCenter: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              if (index == platformState.games.length - 1) {
                debugPrint('The end arrived');
              }
              platformsGamesBloc.add(
                PlatformGamesFetched(platformId: platform),
              );
              debugPrint(index.toString());
              debugPrint(reason.toString());
            },
          ),
          disableGesture: true,
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 10,
            direction: Axis.vertical,
            children: [
              Text(
                "${t.HOME.NO_MATCHES_FOR} ",
                style: const TextStyle(color: Colors.grey),
              ),
              ElevatedButton(
                onPressed: () =>
                    GoRouter.of(context).push("/search-game", extra: platform),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  side: const BorderSide(color: Colors.blue, width: 3),
                  backgroundColor: Colors.black,
                  shape: const StadiumBorder(),
                ),
                child: Text(t.HOME.CREATE),
              ),
            ],
          ),
        );
      }
    } else if (platformState.status == PlatformGamesStatus.failure &&
        platformState.games.isEmpty) {
      return Center(child: Text(t.HOME.ERROR_LOADING_MATCHES));
    } else {
      return Center(child: Text(t.HOME.ERROR_LOADING_MATCHES));
    }
  }

  String _getMatchesTranslation(int amount) {
    if (amount == 0) {
      return t.HOME.NO_MATCHES_FOR;
    } else if (amount == 1) {
      return "$amount ${t.HOME.MATCH}";
    } else {
      return "$amount ${t.HOME.MATCHES}";
    }
  }
}
