import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/platform_game_matches/platform_game_matches_bloc.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/organism/organism_platform_game_matches.dart';

import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/i18n/strings.g.dart';
import '../../utils/platforms.dart';

class GamePage extends StatefulWidget {
  final String game;
  final int platform;
  const GamePage({super.key, required this.game, required this.platform});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final PlatformGameMatchesBloc platformGameMatchesBloc;
  late final PlatformId platformId;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    platformGameMatchesBloc = context.read<PlatformGameMatchesBloc>();
    platformId =
        PlatformId.values.firstWhere((element) => element.id == widget.platform);
    platformGameMatchesBloc
        .add(LoadPlatformGameMatches(platformId: platformId, gameId: widget.game));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    platformGameMatchesBloc.add(RestorePlatformGameMatches());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      platformGameMatchesBloc.add(
          LoadPlatformGameMatches(platformId: platformId, gameId: widget.game));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            FutureBuilder(
                future: RepositoryManager().games.getGameById(widget.game),
                builder: (BuildContext context, AsyncSnapshot<GameData> snapshot) {
                  if (snapshot.hasData) {
                    final GameData game = snapshot.data!;
                    return Column(
                      children: [
                        AtomGameImage(
                            name: game.name, background: game.background),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black12,
                                  Colors.black26,
                                  Colors.black,
                                  Colors.black26,
                                  Colors.black12
                                ]
                              )
                            ),
                          child: ExpandableText(
                            game.description,
                            expandText: t.UTILS.SHOW_MORE,
                            collapseText: t.UTILS.SHOW_LESS,
                            maxLines: 6,
                            animation: true,
                            collapseOnTextTap: true,
                            expandOnTextTap: true,
                            urlStyle: const TextStyle(
                                color: Color.fromARGB(255, 169, 145, 255)),
                          ),
                        ),
                        Text(getPlatformInfo(widget.platform).name),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            OrganismPlatformGameMatches(
                platform: platformId, gameId: widget.game)
          ],
        ),
      ),
    );
  }
}
