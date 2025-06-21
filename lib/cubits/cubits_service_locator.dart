import 'package:get_it/get_it.dart';
import 'package:madnolia/cubits/cubits.dart';

GetIt getItCubit = GetIt.instance;

Future<void> cubitServiceLocatorInit() async {
  getItCubit.registerSingleton(MatchMinutesCubit());
  getItCubit.registerSingleton(MatchUsersCubit());
}
