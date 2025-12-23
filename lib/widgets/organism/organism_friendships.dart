
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../blocs/friendships/friendships_bloc.dart';
import '../../enums/list_status.enum.dart';
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
      case ListStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case ListStatus.failure:
        if (friendshipsBloc.state.friendshipsUsers.isEmpty) {
          return Center(child: Text(translate('FRIENDS.ERROR_LOADING')));
        } else {
          return const MoleculeFriendshipsUsersList();
        }
      case ListStatus.success:
        if (friendshipsBloc.state.friendshipsUsers.isNotEmpty) {
          return const MoleculeFriendshipsUsersList();
        } else {
          return Center(child: Text(translate('FRIENDS.EMPTY')));
        }
    }
  }
}