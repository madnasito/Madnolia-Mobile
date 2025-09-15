import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import 'package:animate_do/animate_do.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';

import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

import '../../widgets/molecules/lists/molecule_user_platforms_buttons.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
  
}

class _NewPageState extends State<NewPage> {
  int selectedPlatform = 0;
  @override
  Widget build(BuildContext context) {

    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is int) {
        selectedPlatform = GoRouterState.of(context).extra as int;
      }
    }

  return CustomScaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FadeIn(
                  delay: const Duration(milliseconds: 300),
                  child: CenterTitleAtom(
                    text: translate("CREATE_MATCH.TITLE"),
                    textStyle: neonTitleText,
                  )),
              const SizedBox(height: 10),
              MoleculeUserPlatformsButtons(),
              // SingleChildScrollView(
            ],
          ),
        )
      
    );
  }
}
