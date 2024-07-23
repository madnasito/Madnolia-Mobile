
import 'package:Madnolia/blocs/blocs.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void servideLocatorInit() {
  getIt.registerSingleton(UserBloc());
}

