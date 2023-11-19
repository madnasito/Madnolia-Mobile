import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:madnolia/pages/auth/login_page.dart';
import 'package:madnolia/pages/auth/register_page.dart';
import 'package:madnolia/pages/create_match_page.dart';
import 'package:madnolia/pages/home/home_new_page.dart';
import 'package:madnolia/pages/user/edit_user_page.dart';
import 'package:madnolia/pages/user/user_matches_page.dart';
import 'package:madnolia/pages/user/user_page.dart';
import 'package:madnolia/pages/user/user_platforms.dart';

import '../pages/home/home_user_page.dart';

// Map<String, WidgetBuilder> getApplicationRoutes() {
//   return <String, WidgetBuilder>{
//     "login": (BuildContext context) => const LoginPage(),
//     "loggedHome": (BuildContext context) => const LoggedHome(),
//     "user": (BuildContext context) => const UserPage(),
//     "user/edit": (BuildContext context) => const UserEditPage(),
//     "new": (BuildContext context) => const NewPage()
//   };
// }

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: "/user",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const UserPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'loggedHome',
          builder: (BuildContext context, GoRouterState state) {
            return const LoggedHome();
          },
        ),
        GoRoute(
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
            return NewPage();
          },
        ),
      ],
    ),
  ],
);
