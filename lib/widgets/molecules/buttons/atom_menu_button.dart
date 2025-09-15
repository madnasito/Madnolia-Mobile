import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AtomMenuButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final String route;
  const AtomMenuButton({super.key, required this.icon, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouterState.of(context).fullPath;
    return ElevatedButton(
      onPressed: () {
        changeRoute(context, route);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        foregroundColor: Colors.pink,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        shadowColor: Colors.transparent,
        elevation: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: startsWithPattern(fullPath!, route)
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                    Color.fromRGBO(255, 31, 75, 0),
                    Color.fromRGBO(255, 31, 75, 0.5),
                    Color.fromRGBO(255, 31, 75, 0.7),
                    Color.fromRGBO(255, 31, 75, 1),
                    Color.fromRGBO(255, 31, 75, 0.7),
                    Color.fromRGBO(255, 31, 75, 0.5),
                    Color.fromRGBO(255, 31, 75, 0),
                  ])
            : null,
        ),
        child: Row(
          children: [
            SizedBox(width: 40, child: icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      )
    );
  }

  bool startsWithPattern(String input, String pattern) {
    // Escapa el patrón para que sea seguro usarlo en una expresión regular
    String escapedPattern = RegExp.escape(pattern);
    
    // Crea una expresión regular que verifica si el string comienza con el patrón
    RegExp regExp = RegExp('^$escapedPattern');

    // Verifica si el input coincide con la expresión regular
    return regExp.hasMatch(input);
  }

}

 void changeRoute(BuildContext context, String route){
    final currentRouteName = "/${ModalRoute.of(context)?.settings.name}";
    if (route != "" && route != currentRouteName) {
      // Cerrar el drawer si está abierto
      final scaffoldState = Scaffold.maybeOf(context);
      if (scaffoldState != null && scaffoldState.isDrawerOpen) {
        scaffoldState.closeDrawer();
      }
      GoRouter.of(context).pushReplacement(route);
    }
  }