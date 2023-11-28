import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:madnolia/pages/auth/login_page.dart';
import 'package:madnolia/pages/auth/register_page.dart';
// import 'package:madnolia/pages/auth/register_page.dart';
import 'package:madnolia/pages/create_match_page.dart';
import 'package:madnolia/pages/home/home_new_page.dart';
import 'package:madnolia/pages/platforms/platform_games_page.dart';
// import 'package:madnolia/pages/home/home_new_page.dart';
import 'package:madnolia/pages/platforms/platforms_page.dart';
import 'package:madnolia/pages/user/edit_user_page.dart';
import 'package:madnolia/pages/user/user_matches_page.dart';
import 'package:madnolia/pages/user/user_page.dart';
// import 'package:madnolia/pages/user/user_platforms.dart';

import '../pages/home/home_user_page.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: "/login",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) async {
        const storage = FlutterSecureStorage();

        String? token = await storage.read(key: "token");

        if (token != null) {
          return "/user";
        } else {
          return null;
        }
      },
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "home",
          name: "home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            path: "register",
            name: "register",
            builder: (context, state) => const RegisterPage()),
        GoRoute(
          path: 'loggedHome',
          builder: (BuildContext context, GoRouterState state) {
            return const LoggedHome();
          },
        ),
        GoRoute(
          path: "platforms",
          routes: <RouteBase>[
            GoRoute(
              name: "Get platform games",
              path: ":id",
              redirect: (context, state) {
                if (state.pathParameters["id"] == null) {
                  return context.namedLocation("platforms");
                } else {
                  return null;
                }
              },
              builder: (context, state) =>
                  PlatformGames(id: state.pathParameters["id"].toString()),
            )
          ],
          builder: (context, state) {
            return const PlatformsPage();
          },
        ),
        GoRoute(
            name: "user",
            path: 'user',
            builder: (BuildContext context, GoRouterState state) {
              return const UserPage();
            },
            routes: [
              GoRoute(
                path: 'edit',
                builder: (BuildContext context, GoRouterState state) {
                  return const UserEditPage();
                },
              ),
              GoRoute(
                path: 'matches',
                builder: (BuildContext context, GoRouterState state) {
                  return const UserMatchesPage();
                },
              ),
            ]),
        GoRoute(
          path: 'new',
          builder: (BuildContext context, GoRouterState state) {
            return const NewPage();
          },
        ),
      ],
    ),
  ],
);
