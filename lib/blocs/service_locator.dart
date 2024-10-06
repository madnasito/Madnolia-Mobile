
import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:Madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:Madnolia/utils/socket_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {

  final Socket socket = await socketHandler();

  getIt.registerSingleton(UserBloc());
  getIt.registerSingleton(SocketsBloc(socket: socket));
  getIt.registerSingleton(GameDataBloc());
}

