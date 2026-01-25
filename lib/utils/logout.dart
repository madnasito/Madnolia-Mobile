import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/matches/matches_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/services/sockets_service.dart';

import '../blocs/friendships/friendships_bloc.dart';

Future<void> logoutApp(BuildContext context) async {
  const storage = FlutterSecureStorage();
  final chatsBloc = context.read<ChatsBloc>();
  final userBloc = context.read<UserBloc>();
  final messageBloc = context.read<MessageBloc>();
  final backgroundService = FlutterBackgroundService();
  final matchesBloc = context.read<MatchesBloc>();
  final platformGamesBloc = context.read<PlatformGamesBloc>();
  final notificationsBloc = context.read<NotificationsBloc>();
  final friendshipsBloc = context.read<FriendshipsBloc>();
  backgroundService.invoke('logout');
  backgroundService.invoke("delete_all_notifications");
  userBloc.add(UserLogOut());
  messageBloc.add(RestoreState());
  matchesBloc.add(RestoreMatchesState());
  chatsBloc.add(RestoreUserChats());
  platformGamesBloc.add(RestorePlatformsGamesState());
  notificationsBloc.add(RestoreNotificationsState());
  friendshipsBloc.add(RestoreFriendshipsState());
  await RepositoryManager().games.deleteAllGames();
  await RepositoryManager().user.deleteUsers();
  await RepositoryManager().match.deleteMatches();
  await RepositoryManager().friendship.deleteFriendships();
  await RepositoryManager().notification.deleteNotifications();
  await RepositoryManager().chatMessage.deleteMessages();
  await RepositoryManager().conversation.deleteConversations();
  stopBackgroundService();
  await storage.deleteAll();
}
