import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/widgets/organism/form/organism_edit_match_form.dart';
import 'package:madnolia/widgets/organism/modal/organism_match_info_modal.dart';

import '../../blocs/user/user_bloc.dart';

class OrganismMatchInfo extends StatelessWidget {
  final MatchData match;
  final GameData game;
  final String userId;

  const OrganismMatchInfo({super.key, required this.match, required this.userId, required this.game});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserBloc>().state.id;
    final now = DateTime.now();

    if (match.date.isBefore(now) || userId != match.user) {
      return OrganismMatchInfoModal(match: match);
    }

    if (match.status == MatchStatus.cancelled || match.status == MatchStatus.finished) {
      return const SizedBox();
    }

    return OrganismEditMatchForm(match: match, game: game);
  }
}