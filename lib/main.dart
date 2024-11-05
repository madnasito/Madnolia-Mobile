
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chat_messages/chat_messages_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/blocs/login_provider.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'dart:ui';

//for mobile

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  serviceLocatorInit();
  Locale deviceLocale = window.locale;// or html.window.locale
  String langCode = deviceLocale.languageCode;

  List<String> supportedLangs = ['en', 'es'];

   var delegate = await LocalizationDelegate.create(
          fallbackLocale: supportedLangs.contains(langCode) ? langCode : 'en',
          supportedLocales: supportedLangs);
    
  // unawaited(MobileAds.instance.initialize());
  // MobileAds.instance.initialize();
  await NotificationService.initializeNotification();
  runApp(LocalizedApp(delegate, const MyApp()) );
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
        BlocProvider(create: (BuildContext context) => getIt<SocketsBloc>()),
        BlocProvider(create: (context) => ChatMessagesBloc())
      ],
      child: LoginProvider(
        child:  MessageProvider(
              child: Portal(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  // builder: (context, child) => Overlay(
                  //   initialEntries: [
                  //     OverlayEntry(builder: (BuildContext context) => AppBarOrganism(child: child!,))
                  //   ],
                  // ), 
                  theme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  title: 'madnolia',
                  routerConfig: router,
                  localizationsDelegates: [
                    localizationDelegate
                  ],
                  supportedLocales: localizationDelegate.supportedLocales,
                  locale: localizationDelegate.currentLocale,
                  key: navigatorKey,
                ),
              ),
          ),
        ),
      ),
    );
    }
}
