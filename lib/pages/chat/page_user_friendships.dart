import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

import '../../widgets/organism/organism_friendships.dart';

class PageUserFriendships extends StatelessWidget {
  const PageUserFriendships({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          CenterTitleAtom(text: translate('FRIENDS.TITLE')),
          Expanded(
            child: OrganismFriendships(),
          )
        ],
      ),
    );
  }
}
