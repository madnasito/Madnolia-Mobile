import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:Madnolia/services/notification_service.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:Madnolia/widgets/organism/app_bar_organism.dart';
import 'package:flutter/material.dart';
import 'package:Madnolia/blocs/login_provider.dart';
import 'package:Madnolia/blocs/message_provider.dart';
import 'package:Madnolia/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  await NotificationService.initializeNotification();
  serviceLocatorInit();

   var delegate = await LocalizationDelegate.create(
          fallbackLocale: 'en',
          supportedLocales: ['en', 'es']);
  
  runApp(LocalizedApp(delegate, const MyApp()) );
}

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
        BlocProvider(create: (BuildContext context) => getIt<SocketsBloc>()),
      ],
      child: LoginProvider(
        child:  MessageProvider(
              child: Portal(
                child: MaterialApp.router(
                  // builder: (context, child) => Overlay(
                  //   initialEntries: [
                  //     OverlayEntry(builder: (BuildContext context) => AppBarOrganism(child: child!,))
                  //   ],
                  // ), 
                  theme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  title: 'Madnolia',
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
