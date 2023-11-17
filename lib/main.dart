import 'package:flutter/material.dart';
import 'package:madnolia/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Madnolia',
      initialRoute: "user",
      routes: getApplicationRoutes(),
    );
  }
}
