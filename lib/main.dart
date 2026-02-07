import 'dart:async';
import 'package:flutter/foundation.dart';
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
import 'package:madnolia/widgets/views/error_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:upgrader/upgrader.dart';

import 'i18n/strings.g.dart'; // Importa las traducciones generadas
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('es', null);
  initializeDateFormatting('en', null);
  DartPluginRegistrant.ensureInitialized();

  // Custom Error Widget for rendering errors
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorView(errorDetails: details);
  };

  // 1. INICIALIZAR slang PRIMERO
  LocaleSettings.useDeviceLocale(); // Esto debe ir antes de cualquier widget

  // Load environment variables
  (kDebugMode)
      ? await dotenv.load(fileName: "assets/.env.dev")
      : await dotenv.load(fileName: "assets/.env.prod");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  serviceLocatorInit();
  cubitServiceLocatorInit();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    if (await getToken() is String) {
      await LocalNotificationsService.initialize();
      await initializeService();
      debugPrint('Service initialized, waiting for login to start');
      await Future.delayed(const Duration(milliseconds: 300));
      startBackgroundService();
    }
  } catch (e) {
    debugPrint('Error initializing service: $e');
  }

  unawaited(MobileAds.instance.initialize());
  MobileAds.instance.initialize();

  AppLifecycleManager().initialize();

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  debugPrint('Current app version: $currentVersion');
  debugPrint(
    'Current locale: ${LocaleSettings.currentLocale.languageCode}',
  ); // Verifica el locale

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  final forceUpdateVersion = remoteConfig.getString(
    'force_update_for_version_mobile',
  );

  debugPrint('Force update version from remote config: $forceUpdateVersion');

  runApp(TranslationProvider(child: const AppWrapper()));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  void dispose() {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<GameDataBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MessageBloc>()),
        BlocProvider(
          create: (BuildContext context) => getIt<PlatformGamesBloc>(),
        ),
        BlocProvider(create: (BuildContext context) => getIt<ChatsBloc>()),
        BlocProvider(
          create: (BuildContext context) => getIt<NotificationsBloc>(),
        ),
        BlocProvider(create: (BuildContext context) => getIt<MatchesBloc>()),
        BlocProvider(
          create: (BuildContext context) => getIt<FriendshipsBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => getIt<PlatformGameMatchesBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => getItCubit<MatchMinutesCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => getItCubit<MatchUsersCubit>(),
        ),
      ],
      child: Portal(
        child: MaterialApp.router(
          // Configuración crucial para las traducciones
          locale: TranslationProvider.of(
            context,
          ).flutterLocale, // Esto obtiene el locale de slang
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color.fromARGB(255, 10, 0, 25),
            canvasColor: const Color.fromARGB(255, 10, 0, 25),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 10, 0, 25),
              brightness: Brightness.dark,
            ).copyWith(surface: const Color.fromARGB(255, 10, 0, 25)),
          ),

          title: 'madnolia',
          routerConfig: router,
          builder: (context, child) {
            return UpgradeAlert(
              navigatorKey: router.routerDelegate.navigatorKey,
              // Upgrader handles store updates (binary change),
              // while Shorebird handles OTA patches (code-push) silently.
              upgrader: Upgrader(
                durationUntilAlertAgain: const Duration(days: 1),
              ),
              child: ColoredBox(
                color: const Color.fromARGB(255, 10, 0, 25),
                child: child!,
              ),
            );
          },
        ),
      ),
    );
  }
}
