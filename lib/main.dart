
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:madnolia/blocs/friendships/friendships_bloc.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/types/app_lifecycle_state.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/matches/matches_bloc.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'i18n/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  
  // Load environment variables first
  (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod") ;

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
  
  serviceLocatorInit();
  cubitServiceLocatorInit();
// Force Portrait Mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Use PlatformDispatcher to get the device locale
  // Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio > 1.0 
  //     ? const Locale('en') // Fallback if needed
  //     : const Locale('en'); // Replace with actual logic to get locale

  // String langCode = deviceLocale.languageCode;

  // List<String> supportedLangs = ['en', 'es'];

  WidgetsFlutterBinding.ensureInitialized(); // add this
  LocaleSettings.useDeviceLocale(); // and this

  
  try {
    if(await getToken() is String) {
      // Initialize notifications first with improved Android 12+ support  
      await LocalNotificationsService.initialize();
      // Solo inicializar el servicio
      await initializeService();
      // El servicio se iniciará cuando el usuario haga login
      debugPrint('Service initialized, waiting for login to start');
      // Esperar un momento para asegurar que el token esté guardado
      
        await Future.delayed(const Duration(milliseconds: 300));
        
        // Inicializar y iniciar el servicio
        startBackgroundService();
    }
  } catch (e) {
    debugPrint('Error initializing service: $e');
  }

  unawaited(MobileAds.instance.initialize());
  MobileAds.instance.initialize();

  // Inicializar el observer del ciclo de vida
  AppLifecycleManager().initialize();

  // Get current app version
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;
  

  debugPrint('Current app version: $currentVersion');

  // Fetch remote config
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  final forceUpdateVersion = remoteConfig.getString('force_update_for_version_mobile');


  debugPrint('Force update version from remote config: $forceUpdateVersion');

  runApp(TranslationProvider(child: AppWrapper()));
}

 GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Wrapper para manejar correctamente el ciclo de vida de la aplicación
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  void dispose() {
    // Limpiar los recursos del AppLifecycleManager
    AppLifecycleManager().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<GameDataBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MessageBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<PlatformGamesBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<ChatsBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<NotificationsBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MatchesBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<FriendshipsBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<PlatformGameMatchesBloc>()),
        BlocProvider(create: (BuildContext context) => getItCubit<MatchMinutesCubit>()),
        BlocProvider(create: (BuildContext context) => getItCubit<MatchUsersCubit>()),
      ],
      child: Portal(
        child: MaterialApp.router(
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          title: 'madnolia',
          routerConfig: router,
          key: navigatorKey,
          ),
      ),
      );
    }
}

// A simple app that only shows the upgrader screen.
// class ForcedUpdateApp extends StatelessWidget {
//   const ForcedUpdateApp({super.key});

//    @override
//    Widget build(BuildContext context) {
//      return MaterialApp(
//        home: UpgradeAlert(
//          child: Scaffold(body: Center(child: Text('Checking for updates...'))),
//        ),
//      );
//    }
//  }