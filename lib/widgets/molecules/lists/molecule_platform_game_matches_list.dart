import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/utils/platforms.dart';

import '../../../blocs/platform_game_matches/platform_game_matches_bloc.dart';

class MoleculePlatformGameMatchesList extends StatefulWidget {

  final PlatformId platform;
  final String gameId;

  const MoleculePlatformGameMatchesList({super.key, required this.platform, required this.gameId});

  @override
  State<MoleculePlatformGameMatchesList> createState() => _MoleculePlatformGameMatchesListState();
}

class _MoleculePlatformGameMatchesListState extends State<MoleculePlatformGameMatchesList> {
  late final _scrollController = ScrollController();
  late final PlatformGameMatchesBloc platformGameMatchesBloc;

  @override
  void initState() {
    super.initState();
    platformGameMatchesBloc = context.read<PlatformGameMatchesBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: platformGameMatchesBloc.state.gameMatches.length,
      itemBuilder: (BuildContext context, int index) {
        final matches = platformGameMatchesBloc.state.gameMatches;
        return Container(
          margin:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.black26,
              border: Border.all(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            onTap: () => GoRouter.of(context)
                .push("/match/${matches[index].id}"),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(matches[index].title, style: const TextStyle(fontSize: 20, overflow: TextOverflow.fade),),
                SvgPicture.asset(
                  getPlatformInfo(widget.platform.id).path,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 60,
                )
              ],
            ),
            shape: const CircleBorder(),
            subtitle: matches[index].date.isAfter(DateTime.now()) ?
            Text(
              matches[index].date
              .toString()
              .substring(0, 16),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color.fromARGB(255, 176, 229, 255)),
            ) :
            Text(
              translate(translate('MATCH.STATUS.RUNNING')),
              style: const TextStyle(color: Color.fromARGB(255, 142, 255, 236), fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  void _onScroll() {
    debugPrint('Is bottom: $_isBottom');
    if (_isBottom) {
      platformGameMatchesBloc.add(LoadPlatformGameMatches(platformId: widget.platform, gameId: widget.gameId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
    (_scrollController.position.maxScrollExtent * 0.9);
  }
}