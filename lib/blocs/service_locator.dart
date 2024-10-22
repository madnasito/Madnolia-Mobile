
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chat_messages/chat_messages_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/utils/socket_handler.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {

  getIt.registerSingleton(UserBloc());
  getIt.registerSingleton(SocketsBloc(SocketHandler()));
  getIt.registerSingleton(GameDataBloc());
  getIt.registerSingleton(ChatMessagesBloc());
}

