import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:madnolia/models/chat_user_model.dart' show ChatUser;

class MoleculeUserHeader extends StatelessWidget {

  final ChatUser user;
  const MoleculeUserHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      color: Colors.black45,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                user.thumb),
            radius: 30,
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name),
              Text("@${user.username}", style: TextStyle(fontSize: 12)),
            ],
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.call_outlined),
          // ),
          // IconButton(
          //   onPressed: () => _showCallOptions(context),
          //   icon: const Icon(CupertinoIcons.video_camera),
          // ),
        ],
      ),
    );
  }
}