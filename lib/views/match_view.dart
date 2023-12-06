import 'package:flutter/material.dart';

import 'package:madnolia/models/match_model.dart';

class MatchOwnerView extends StatelessWidget {
  final Match match;
  const MatchOwnerView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(match.img != null ? match.img.toString() : ""),
              Positioned(
                bottom: 2,
                left: 2,
                child: Text(
                  match.gameName,
                  style: const TextStyle(backgroundColor: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MatchUserView extends StatelessWidget {
  final Match match;
  const MatchUserView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MatchChat extends StatelessWidget {
  final Match match;
  const MatchChat({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  match.message,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  match.gameName,
                  style: const TextStyle(fontSize: 6),
                ),
              ],
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.network(
                filterQuality: FilterQuality.medium,
                match.img.toString(),
                width: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
