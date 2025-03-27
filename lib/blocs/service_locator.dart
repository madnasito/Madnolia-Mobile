
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {

  getIt.registerSingleton(UserBloc());
  getIt.registerSingleton(GameDataBloc());
}

