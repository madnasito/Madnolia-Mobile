import 'package:get_it/get_it.dart';
import 'package:madnolia/services/sockets_service.dart';

GetIt getItSingletons = GetIt.instance;

Future<void> servicesSingleton() async {
  getItSingletons.registerSingleton(SocketService());
}