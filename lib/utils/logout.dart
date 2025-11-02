import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/services/sockets_service.dart';

Future<void> logoutApp(BuildContext context) async {
  const storage = FlutterSecureStorage();
  final chatsBloc = context.read<ChatsBloc>();
  final userBloc = context.read<UserBloc>();
  final messageBloc = context.read<MessageBloc>();
  final backgroundService = FlutterBackgroundService();
  final matchesBloc = context.read<PlayerMatchesBloc>();
  final platformGamesBloc = context.read<PlatformGamesBloc>();
  backgroundService.invoke('logout');
  backgroundService.invoke("delete_all_notifications");
  userBloc.logOutUser();
  messageBloc.add(RestoreState());
  matchesBloc.add(RestoreMatchesState());
  chatsBloc.add(RestoreUserChats());
  platformGamesBloc.add(RestorePlatformsGamesState());
  RepositoryManager().games.deleteAllGames();
  RepositoryManager().user.deleteUsers();
  RepositoryManager().match.deleteMatches();
  RepositoryManager().friendship.deleteFriendships();
  RepositoryManager().notification.deleteNotifications();
  if(!context.mounted) return;
  stopBackgroundService();
  await storage.deleteAll();
  
}