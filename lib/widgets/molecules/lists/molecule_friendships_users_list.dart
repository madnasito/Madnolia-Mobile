
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/friendships/friendships_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/database/database.dart';

import '../../../models/chat_user_model.dart';

class MoleculeFriendshipsUsersList extends StatefulWidget {
  const MoleculeFriendshipsUsersList({super.key});

  @override
  State<MoleculeFriendshipsUsersList> createState() => _MoleculeFriendshipsUsersListState();
}

class _MoleculeFriendshipsUsersListState extends State<MoleculeFriendshipsUsersList> {

  late final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll(){
    if(_isBottom){
      final friendshipsBloc = context.read<FriendshipsBloc>();
      friendshipsBloc.add(LoadFriendships());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }

  @override
  Widget build(BuildContext context) {

    
    final friendshipsBloc = context.watch<FriendshipsBloc>();
    final List<UserData> users = friendshipsBloc.state.friendshipsUsers;
    final bool hasReachedMax = friendshipsBloc.state.hasReachedMax;

    return FadeInUp(
        duration: const Duration(milliseconds: 300),
        delay: Duration(milliseconds: 100),
        child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: hasReachedMax ? users.length : users.length + 1,
        itemBuilder: (BuildContext context, int index) {

          if (index >= users.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }

          final user = users[index];
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: InkWell(
                onTap: () {
                  context.pushNamed(
                    "user-chat", 
                    extra: ChatUser(
                      id: user.id,
                      name: user.name,
                      thumb: user.thumb,
                      username: user.username,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E).withValues(alpha:  0.8), // Dark blue-ish grey
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: const Color(0xFF00FFFF).withValues(alpha:  0.3), // Cyan accent
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00FFFF).withValues(alpha:  0.5),
                              blurRadius: 6.0,
                              spreadRadius: 1.0,
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFF1A1A2E),
                          backgroundImage: CachedNetworkImageProvider(user.thumb),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontFamily: 'Cyberverse',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '@${user.username}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha:  0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white70),
                    ],
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}