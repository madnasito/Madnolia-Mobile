
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;
import 'package:madnolia/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/database/providers/db_provider.dart';
import 'package:madnolia/services/sockets_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  serviceLocatorInit();
  cubitServiceLocatorInit();
  await BaseDatabaseProvider.database;

  (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod") ;

  // Use PlatformDispatcher to get the device locale
  Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio > 1.0 
      ? const Locale('en') // Fallback if needed
      : const Locale('en'); // Replace with actual logic to get locale

  String langCode = deviceLocale.languageCode;

  List<String> supportedLangs = ['en', 'es'];

  LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: supportedLangs.contains(langCode) ? langCode : 'en',
    supportedLocales: supportedLangs,
  );

  try {
    if(await getToken() is String) await initializeService();
  } catch (e) {
    debugPrint(e.toString());
  }

  unawaited(MobileAds.instance.initialize());
  MobileAds.instance.initialize();

  runApp(LocalizedApp(delegate, const MyApp()));
}

 GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      
      child:  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<GameDataBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MessageBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<PlatformGamesBloc>()),
        BlocProvider(create: (BuildContext context) => getItCubit<MatchMinutesCubit>()),
        BlocProvider(create: (BuildContext context) => getItCubit<MatchUsersCubit>()),
      ],
      child:MessageProvider(
              child: Portal(
                child: MaterialApp.router(
                  theme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  title: 'madnolia',
                  routerConfig: router,
                  localizationsDelegates: [
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    localizationDelegate
                  ],
                  supportedLocales: localizationDelegate.supportedLocales,
                  locale: localizationDelegate.currentLocale,
                  key: navigatorKey,
                ),
              ),
          ),
        ),
      
    );
    }
}
