import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/atoms/input/atom_search_input.dart';

class OrganismSearchGames extends StatelessWidget {
  const OrganismSearchGames({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AtomSearchInput(
              searchController: searchController,
              placeholder:
                t.CREATE_MATCH.SEARCH_GAME,
              onChanged: (value) {},
            ),
          )
        ),
        
      ],
    );
  }
}