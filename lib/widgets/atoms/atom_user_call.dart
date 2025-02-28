import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/models/chat_user_model.dart';

class AtomUserCall extends StatelessWidget {
  final ChatUser chatUser;
  final double imgSize;
  const AtomUserCall({super.key, required this.chatUser, required this.imgSize});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: const RadialGradient(colors: [Colors.black, Colors.blue, Colors.blueAccent, Colors.greenAccent]),
                ),
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(chatUser.thumb),
                  radius: imgSize,
                ),
              ),
              Text(chatUser.name)
            ],
          ),
        ),
    );
  }
}