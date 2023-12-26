import 'package:Madnolia/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:Madnolia/widgets/language_builder.dart';
import 'package:Madnolia/blocs/login_provider.dart';
import 'package:Madnolia/blocs/message_provider.dart';
import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/routes/routes.dart';
import 'package:Madnolia/services/sockets_service.dart';
import 'package:multi_language_json/multi_language_json.dart';
import 'package:provider/provider.dart';

void main() async {
  await NotificationService.initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static late MultiLanguageBloc language;

  @override
  Widget build(BuildContext context) {
    final locale = WidgetsFlutterBinding.ensureInitialized().window.locale;

// Imprime el idioma predeterminado, por ejemplo: "es"
    print(locale.languageCode);
    return LoginProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => SocketService())
        ],
        child: MessageProvider(
          child: LanguageBuilder(
            child: MaterialApp.router(
              theme: ThemeData(
                brightness: Brightness.dark,
              ),
              title: 'Madnolia',
              routerConfig: router,
              key: navigatorKey,
            ),
          ),
        ),
      ),
    );
  }
}
