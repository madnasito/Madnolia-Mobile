
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chat_messages/chat_messages_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/utils/socket_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {

  final Socket socket = await socketHandler();

  getIt.registerSingleton(UserBloc());
  getIt.registerSingleton(SocketsBloc(socket: socket));
  getIt.registerSingleton(GameDataBloc());
  getIt.registerSingleton(ChatMessagesBloc());
}

