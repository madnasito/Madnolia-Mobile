import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';

import '../../blocs/friendships/friendships_bloc.dart';
import '../../enums/bloc_status.enum.dart';
import '../molecules/lists/molecule_friendships_users_list.dart';

class OrganismFriendships extends StatefulWidget {
  const OrganismFriendships({super.key});

  @override
  State<OrganismFriendships> createState() => _OrganismFriendshipsState();
}

class _OrganismFriendshipsState extends State<OrganismFriendships> {
  @override
  void initState() {
    super.initState();
    context.read<FriendshipsBloc>().add(LoadFriendships());
  }

  @override
  Widget build(BuildContext context) {
    final friendshipsBloc = context.watch<FriendshipsBloc>();

    switch (friendshipsBloc.state.status) {
      case BlocStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case BlocStatus.failure:
        if (friendshipsBloc.state.friendshipsUsers.isEmpty) {
          return Center(child: Text(t.FRIENDS.ERROR_LOADING));
        } else {
          return const MoleculeFriendshipsUsersList();
        }
      case BlocStatus.success:
        if (friendshipsBloc.state.friendshipsUsers.isNotEmpty) {
          return const MoleculeFriendshipsUsersList();
        } else {
          return Center(child: Text(t.FRIENDS.EMPTY));
        }
    }
  }
}
