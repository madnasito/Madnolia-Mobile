import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String title;
  final String image;
  final Widget buttom;
  const MatchCard({
    super.key,
    required this.title,
    required this.image,
    required this.buttom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(image),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    title,
                    style: const TextStyle(
                        backgroundColor: Colors.black54, fontSize: 15),
                  ))
            ],
          ),
          buttom
        ],
      ),
    );
  }
}
