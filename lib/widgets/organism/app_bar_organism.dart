import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';

class AppBarOrganism extends StatelessWidget {
  final Widget child;
  const AppBarOrganism({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    return Scaffold(
      drawer: BlocBuilder(
        bloc: userBloc,
        builder: (BuildContext context, state) { 
          if(userBloc.state.loadedUser){
            return Drawer(
            surfaceTintColor: Colors.pink,
            backgroundColor: const Color.fromARGB(96, 9, 4, 24),
            child: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => GoRouter.of(context).push("/user/edit"),
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const SizedBox(width: 0),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(userBloc.state.thumb),
                          minRadius: 40,
                          maxRadius: 50,
                          backgroundColor: Colors.white,
                        ),
                        Text(
                          userBloc.state.name,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 230),
                      // _MenuButton(
                      //   icon: Icons.gamepad_outlined,
                      //   title: "Platforms",
                      //   route: "/platforms",
                      // ),
                      _MenuButton(
                        icon: Icons.bolt_outlined,
                        title: t.HEADER.MATCH,
                        route: "/new",
                      ),
                      _MenuButton(
                        icon: Icons.notifications_outlined,
                        title:
                            t.HEADER.NOTIFICATIONS,
                        route: "/notifications",
                      ),
                      _MenuButton(
                          icon: Icons.person_outline_outlined,
                          title: t.HEADER.PROFILE,
                          route: "/user"),
                      const SizedBox(height: 230),
                    ],
                  ),
                  Positioned(
                      bottom: 30,
                      left: 20,
                      child: GestureDetector(
                        onTap: () async {
                          const storage = FlutterSecureStorage();
                          await storage.delete(key: "token");
                          if(!context.mounted) return;
                          GoRouter.of(context).push("/home");
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                              size: 30,
                            ),
                            Text(
                              t.HEADER.LOGOUT,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
          }else {
            return Container();
          }
         }
        ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const _MenuButton(
      {required this.icon, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = "/${ModalRoute.of(context)?.settings.name}";
    final fullPath = GoRouterState.of(context).fullPath;
    return ElevatedButton(
        onPressed: () {
          if (route != "" && route != currentRouteName) {
            GoRouter.of(context).push(route);
          }
        },
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.pink,
            backgroundColor: const Color.fromARGB(20, 48, 43, 95),
            surfaceTintColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(0),
            shadowColor: Colors.transparent,
            elevation: 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
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
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              Text(
                "     $title",
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
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
