import 'package:flutter/material.dart';
import 'package:madnolia/models/match/full_match.model.dart';

import '../form/organism_edit_match_form.dart';

class OrganismMatchInfoModal extends StatelessWidget {

  final FullMatch match;

  const OrganismMatchInfoModal({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      final Size screenSize = MediaQuery.of(context).size;
      showModalBottomSheet(
        enableDrag: true,
        barrierLabel: "HELLO",
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: screenSize.height * 0.7,
            width: screenSize.width,
            child: Center(
              heightFactor: 5,
              widthFactor: 2,
              child: OrganismEditMatchForm(match: match,),
            ),
          );
        }
      );
    }, icon: const Icon(Icons.info_outline_rounded, color: Colors.white));
  }
}