import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/utils/platforms.dart';

import '../../../blocs/platform_game_matches/platform_game_matches_bloc.dart';

class MoleculePlatformGameMatchesList extends StatelessWidget {
  final PlatformId platform;
  final String gameId;

  const MoleculePlatformGameMatchesList({
    super.key,
    required this.platform,
    required this.gameId,
  });

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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            border: Border.all(
              color: const Color(0xFF00F0FF).withValues(alpha: 0.16),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              // Neon accent bar
              Container(
                width: 4,
                height: matches[index].description.isNotEmpty ? 87 : 69,
                decoration: BoxDecoration(
                  color: const Color(0xFF00F0FF).withValues(alpha: 0.35),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  onTap: () =>
                      GoRouter.of(context).push("/match/${matches[index].id}"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        matches[index].title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      const SizedBox(height: 4),
                      matches[index].description.isNotEmpty
                          ? Text(
                              matches[index].description,
                              style: const TextStyle(
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white70,
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(height: 6),
                      // Fecha integrada al title para alinear con el título
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 14,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          matches[index].date.isAfter(DateTime.now())
                              ? Text(
                                  '${DateFormat('EEE, d MMM', LocaleSettings.currentLocale.languageCode).format(matches[index].date)} · ${DateFormat('HH:mm').format(matches[index].date)}',
                                  style: const TextStyle(
                                    color: Color(0xFF9FFBFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Text(
                                  t.MATCH.STATUS.RUNNING,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 142, 255, 236),
                                    fontSize: 15,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      getPlatformInfo(platform.id).path,
                      colorFilter: const ColorFilter.mode(
                        Colors.white70,
                        BlendMode.srcIn,
                      ),
                      width: 44,
                    ),
                  ),
                  // Si la fecha es futura, la mostramos dentro del title; si no, mostrar estado
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
