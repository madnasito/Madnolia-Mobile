import 'package:Madnolia/pages/game/game_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:Madnolia/pages/auth/login_page.dart';
import 'package:Madnolia/pages/auth/register_page.dart';
// import 'package:Madnolia/pages/auth/register_page.dart';
import 'package:Madnolia/pages/new/create_match_page.dart';
import 'package:Madnolia/pages/home/home_new_page.dart';
import 'package:Madnolia/pages/match_page.dart';
import 'package:Madnolia/pages/new/match_form_page.dart';
import 'package:Madnolia/pages/invitations_page.dart';
import 'package:Madnolia/pages/platforms/platform_games_page.dart';
// import 'package:Madnolia/pages/home/home_new_page.dart';
import 'package:Madnolia/pages/platforms/platforms_page.dart';
import 'package:Madnolia/pages/user/edit_user_page.dart';
import 'package:Madnolia/pages/user/user_matches_page.dart';
import 'package:Madnolia/pages/user/user_page.dart';
import 'package:Madnolia/pages/user/user_platforms.dart';

// import 'package:Madnolia/pages/user/user_platforms.dart';

import '../pages/home/home_user_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// The route configuration.
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder(
            future: getToken(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return const HomeUserPage();
              } else {
                return const HomePage();
              }
            });
      },
      routes: <RouteBase>[
        GoRoute(
            path: "home",
            name: "home",
            builder: (context, state) => const HomePage()),
        GoRoute(
            path: "home-user",
            name: "home-user",
            builder: (context, state) => const HomeUserPage()),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            path: "register",
            name: "register",
            builder: (context, state) => RegisterPage()),
        GoRoute(
          name: "platforms",
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
          path: "notifications",
          name: "notifications",
          builder: (context, state) => const InvitationsPage(),
        ),
        GoRoute(
            name: "user",
            path: 'user',
            builder: (BuildContext context, GoRouterState state) {
              return const UserPage();
            },
            routes: [
              GoRoute(
                name: "edit-user",
                path: 'edit',
                builder: (BuildContext context, GoRouterState state) {
                  return const UserEditPage();
                },
              ),
              GoRoute(
                name: "user-matches",
                path: 'matches',
                builder: (BuildContext context, GoRouterState state) {
                  return const UserMatchesPage();
                },
              ),
              GoRoute(
                  path: "platforms",
                  name: "user-platforms",
                  builder: (context, state) => const UserPlatformsPage())
            ]),
        GoRoute(
          name: "new",
          path: 'new',
          builder: (BuildContext context, GoRouterState state) {
            return NewPage();
          },
          routes: [
            GoRoute(
              path: "match",
              builder: (context, state) => const MatchFormPage(),
            )
          ],
        ),
        GoRoute(
          path: "match",
          name: "match",
          builder: (context, state) => const MatchPage(),
        ),
        GoRoute(
            path: "game", name: "game", builder: (context, state) => const GamePage())
      ],
    ),
  ],
);

Future<String?> getToken() async {
  const storage = FlutterSecureStorage();

  final token = await storage.read(key: "token");

  return token;
}
