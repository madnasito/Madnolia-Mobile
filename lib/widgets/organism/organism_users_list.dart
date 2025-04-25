import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_connection_button.dart' show MoleculeConnectionButton;

class OrganismUsersList extends StatelessWidget {
  final List<SimpleUser> users;
  const OrganismUsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(user.thumb),
          ),
          subtitle: Text(
            user.username,
            style: const TextStyle(color: Colors.white54),
          ),
          title: Text(user.name),
          trailing: MoleculeConnectionButton(simpleUser: user),
        );
      },
    );
  }
}