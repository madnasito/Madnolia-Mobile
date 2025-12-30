import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/utils/platforms.dart';

import '../../../blocs/platform_game_matches/platform_game_matches_bloc.dart';

class MoleculePlatformGameMatchesList extends StatelessWidget {

  final PlatformId platform;
  final String gameId;

  const MoleculePlatformGameMatchesList({super.key, required this.platform, required this.gameId});

  @override
  Widget build(BuildContext context) {
    final platformGameMatchesBloc = context.read<PlatformGameMatchesBloc>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(matches[index].title, style: const TextStyle(fontSize: 20, overflow: TextOverflow.fade),),
                Text(
                  matches[index].description,
                  style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis, color: Colors.white70)
                ),
              ],
            ),
            shape: const CircleBorder(),
            trailing: SvgPicture.asset(
                  getPlatformInfo(platform.id).path,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 60,
                ),
            subtitle: matches[index].date.isAfter(DateTime.now()) ?
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                matches[index].date
                .toString()
                .substring(0, 16),
                style: const TextStyle(color: Color.fromARGB(255, 176, 229, 255)),
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                t.MATCH.STATUS.RUNNING,
                style: const TextStyle(color: Color.fromARGB(255, 142, 255, 236), fontSize: 17)
              ),
            ),
          ),
        );
      },
    );
  }
}