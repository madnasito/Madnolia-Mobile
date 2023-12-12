import 'package:flutter/material.dart';
import 'package:madnolia/blocs/login_provider.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/providers/user_provider.dart';
import 'package:madnolia/routes/routes.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => SocketService())
        ],
        child: MessageProvider(
          child: MaterialApp.router(
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
            title: 'Madnolia',
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
