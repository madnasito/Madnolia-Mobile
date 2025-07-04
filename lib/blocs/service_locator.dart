
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {

  getIt.registerSingleton(UserBloc());
  getIt.registerSingleton(GameDataBloc());
  getIt.registerSingleton(MessageBloc());
  getIt.registerSingleton(PlatformGamesBloc());
  getIt.registerSingleton(ChatsBloc());
}

