import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/friendships/friendships_bloc.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

import '../../widgets/organism/organism_friendships.dart';

class PageUserFriendships extends StatelessWidget {
  const PageUserFriendships({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CustomMaterialIndicator(
        autoRebuild: false,
        onRefresh: () async {
          final friendshipsBloc = context.read<FriendshipsBloc>();
          friendshipsBloc.add(RestoreFriendshipsState());
          friendshipsBloc.add(LoadFriendships(reload: true));
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            CenterTitleAtom(text: translate('FRIENDS.TITLE')),
            const SizedBox(height: 10),
            Expanded(
              child: OrganismFriendships(),
            )
          ],
        ),
      ),
    );
  }
}
