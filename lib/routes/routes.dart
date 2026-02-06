import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/pages/auth/recover_password_page.dart';
import 'package:madnolia/pages/auth/recover_password_token_page.dart';
import 'package:madnolia/pages/chat/user_chat_page.dart';
import 'package:madnolia/pages/chat/chats_page.dart';
import 'package:madnolia/pages/game/game_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:madnolia/pages/auth/login_page.dart';
import 'package:madnolia/pages/auth/register_page.dart';
import 'package:madnolia/pages/game/search_game_page.dart';
import 'package:madnolia/pages/match/matches_page.dart';
import 'package:madnolia/pages/new/create_match_page.dart';
import 'package:madnolia/pages/home/home_new_page.dart';
import 'package:madnolia/pages/match/match_page.dart';
import 'package:madnolia/pages/match/match_form_page.dart';
import 'package:madnolia/pages/notifications/notifications_page.dart';
import 'package:madnolia/pages/platforms/platform_games_page.dart';
import 'package:madnolia/pages/platforms/platforms_page.dart';
import 'package:madnolia/pages/search/search_page.dart';
import 'package:madnolia/pages/settings/edit_user_page.dart';
import 'package:madnolia/pages/settings/settings_page.dart';
import 'package:madnolia/pages/settings/user_platforms.dart';
import 'package:madnolia/pages/settings/user_profile_page.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/scaffolds/unloged_scaffold.dart';

import '../pages/chat/page_user_friendships.dart';
import '../pages/home/home_user_page.dart';
import '../pages/settings/page_reports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// The route configuration.
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  redirect: (context, state) async {
    debugPrint("Redirecting to ${state.matchedLocation}");
    final token = await getToken();
    final bool isLoggedIn = token != null;

    // Define guest-only routes
    final isGuestRoute =
        state.matchedLocation == '/welcome' ||
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register' ||
        state.matchedLocation == '/recover-password' ||
        state.matchedLocation.startsWith('/auth/recover-password-token');

    final isRoot = state.matchedLocation == '/';

    if (!isLoggedIn) {
      if (isRoot || !isGuestRoute) {
        return '/welcome';
      }
      return null;
    }

    if (isGuestRoute || isRoot) {
      return '/home-user';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const UnlogedScaffold(body: HomePage()),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const UnlogedScaffold(body: HomePage()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) =>
          const UnlogedScaffold(showBackButton: true, body: LoginPage()),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => UnlogedScaffold(
        scrollable: false,
        showBackButton: true,
        body: RegisterPage(),
      ),
    ),
    GoRoute(
      path: '/recover-password',
      name: 'recover-password',
      builder: (BuildContext context, GoRouterState state) =>
          const UnlogedScaffold(
            showBackButton: true,
            body: ForgotPasswordPage(),
          ),
    ),
    GoRoute(
      path: '/auth/recover-password-token/:token',
      builder: (context, state) => UnlogedScaffold(
        showBackButton: true,
        body: RecoverPasswordTokenPage(
          token: state.pathParameters['token'].toString(),
        ),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return CustomScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home-user',
          name: 'home-user',
          builder: (context, state) => const HomeUserPage(),
        ),
        GoRoute(
          path: "/chat",
          name: "chat",
          builder: (context, state) => const ChatsPage(),
        ),
        GoRoute(
          path: "/user-chat",
          name: "user-chat",
          builder: (context, state) => const UserChatPage(),
        ),
        GoRoute(
          path: "/search",
          name: "search",
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/friendships',
          name: 'friendships',
          builder: (BuildContext context, GoRouterState state) =>
              const PageUserFriendships(),
        ),
        GoRoute(
          name: "platforms",
          path: "/platforms",
          builder: (context, state) => const PlatformsPage(),
          routes: <RouteBase>[
            GoRoute(
              name: "Get platform games",
              path: ":id",
              builder: (context, state) =>
                  PlatformGames(id: state.pathParameters["id"].toString()),
            ),
          ],
        ),
        GoRoute(
          path: "/notifications",
          name: "notifications",
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: "/matches",
          name: "matches",
          builder: (context, state) => const MatchesPage(),
        ),
        GoRoute(
          path: '/user/:id',
          builder: (context, state) =>
              UserProfilePage(id: state.pathParameters['id'].toString()),
        ),
        GoRoute(
          name: "settings",
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) =>
              const SettingsPage(),
          routes: [
            GoRoute(
              name: "edit-profile",
              path: 'edit-profile',
              builder: (BuildContext context, GoRouterState state) =>
                  const UserEditPage(),
            ),
            GoRoute(
              path: "platforms",
              name: "user-platforms",
              builder: (context, state) => const UserPlatformsPage(),
            ),
            GoRoute(
              path: "reports",
              name: "reports",
              builder: (context, state) => const PageReports(),
            ),
          ],
        ),
        GoRoute(
          name: "new",
          path: '/new',
          builder: (BuildContext context, GoRouterState state) =>
              const NewPage(),
          routes: [
            GoRoute(
              path: "match",
              builder: (context, state) => const MatchFormPage(),
            ),
          ],
        ),
        GoRoute(
          path: "/match/:id",
          builder: (context, state) {
            return FutureBuilder(
              future: getToken(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return MatchPage(id: state.pathParameters['id'].toString());
                } else if (snapshot.hasError) {
                  return Center(child: Text(t.MATCH.ERROR_LOADING));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
        GoRoute(
          path: "/platform/:platform/:game",
          name: "game",
          builder: (context, state) {
            try {
              int platform = int.parse(
                state.pathParameters['platform'].toString(),
              );
              String game = state.pathParameters['game'].toString();
              return GamePage(game: game, platform: platform);
            } catch (e) {
              context.go("/home-user");
              return const SizedBox.shrink();
            }
          },
        ),
        GoRoute(
          path: "/search-game",
          name: "search game",
          builder: (context, state) => const SearchGamePage(),
        ),
      ],
    ),
  ],
);

Future<String?> getToken() async {
  try {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: "token");

    if (token == null) {
      stopBackgroundService();
      return null;
    }

    return token;
  } catch (e) {
    stopBackgroundService();
    return null;
  }
}
