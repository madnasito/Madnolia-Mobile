
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chat_messages/chat_messages_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalMaterialLocalizations, GlobalWidgetsLocalizations;
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'dart:ui';


import 'package:madnolia/services/local_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  serviceLocatorInit();
  cubitServiceLocatorInit();

  // Use PlatformDispatcher to get the device locale
  Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio > 1.0 
      ? const Locale('en') // Fallback if needed
      : const Locale('en'); // Replace with actual logic to get locale

  String langCode = deviceLocale.languageCode;

  List<String> supportedLangs = ['en', 'es'];

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: supportedLangs.contains(langCode) ? langCode : 'en',
    supportedLocales: supportedLangs,
  );

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
    LocalNotificationsService.initialize();
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      
      child:  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<GameDataBloc>()),
        BlocProvider(create: (BuildContext context) => ChatMessagesBloc()),
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
