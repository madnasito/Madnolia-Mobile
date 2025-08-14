
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:madnolia/types/app_lifecycle_state.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
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
import 'package:madnolia/services/local_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  
  // Load environment variables first
  (kDebugMode) ? await dotenv.load(fileName: "assets/.env.dev") : await dotenv.load(fileName: "assets/.env.prod") ;
  
  
  serviceLocatorInit();
  cubitServiceLocatorInit();
  await BaseDatabaseProvider.database;

  debugPrint(dotenv.get("FIREBASE_API_KEY_ANDROID"));
    debugPrint(dotenv.get("FIREBASE_MESSAGE_SENDER_ID"));
    debugPrint(dotenv.get("FIREBASE_PROJECT_ID"));
    debugPrint(dotenv.get("FIREBASE_DATABASE_URL"));
    debugPrint(dotenv.get("FIREBASE_STORAGE_BUCKET"));
    debugPrint(dotenv.get("IOS_BUNDLE_ID"));

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

  // Initialize Firebase after dotenv is loaded
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      debugPrint('Firebase already initialized');
    } else {
      rethrow;
    }
  }
  
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

  runApp(LocalizedApp(delegate, const AppWrapper()));
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
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      
      child:  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<GameDataBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MessageBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<PlatformGamesBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<ChatsBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<PlayerMatchesBloc>()),
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
