
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/pages/auth/recover_password_page.dart';
import 'package:madnolia/pages/chat/user_chat_page.dart';
import 'package:madnolia/pages/chat/chats_page.dart';
import 'package:madnolia/pages/chat/room_call_page.dart';
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
import 'package:madnolia/pages/user/edit_user_page.dart';
import 'package:madnolia/pages/user/user_page.dart';
import 'package:madnolia/pages/user/user_platforms.dart';
import 'package:madnolia/pages/user/user_profile_page.dart';
import 'package:madnolia/services/sockets_service.dart';


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
              } else if(snapshot.hasError) {
                return const HomePage();
              }
              else {
                return const Center(child: CircularProgressIndicator(),);
              }
            });
      },
      routes: <RouteBase>[
        GoRoute(
            path: "home",
            name: "home",
            builder: (context, state) => const HomePage()),
        GoRoute(
          path: "chat",
          name: "chat",
          builder: (context, state) => const ChatsPage()
        ),
        GoRoute(
          path: "user-chat",
          name: "user-chat",
          builder: (context, state) => const UserChatPage()
        ),
        GoRoute(
          path: "search",
          name: "search",
          builder: (context, state) => const SearchPage()
        ),
        GoRoute(
            path: "home-user",
            name: "home-user",
            builder: (context, state) => const HomeUserPage()),
        GoRoute(
          path: 'login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'recover-password',
          name: 'recover-password',
          builder: (BuildContext context, GoRouterState state) {
            return const ForgotPasswordPage();
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
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: "matches",
          name: "matches",
          builder: (context, state) => const MatchesPage(),
        ),
        GoRoute(path: 'user/:id',
          builder: (context, state) => UserProfilePage(id: state.pathParameters['id'].toString())
        ),
        GoRoute(
            name: "me",
            path: 'me',
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
                  path: "platforms",
                  name: "user-platforms",
                  builder: (context, state) => const UserPlatformsPage())
            ]),
        GoRoute(
          name: "new",
          path: 'new',
          builder: (BuildContext context, GoRouterState state) => const NewPage(),
          routes: [
            GoRoute(
              path: "match",
              builder: (context, state) => const MatchFormPage(),
            )
          ],
        ),
        GoRoute(
          path: "match/:id",
          builder: (context, state) {
            return FutureBuilder(
              future: getToken(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return MatchPage(id: state.pathParameters['id'].toString());
                } else if(snapshot.hasError){
                  return Center(child: Text(translate('MATCH.ERROR_LOADING')));
                }else {
                  return Center(child: CircularProgressIndicator(),);
                }
              }
            );
          },
          routes: [
            GoRoute(
              name: "match_call",
              path: "call",
              builder: (BuildContext context, GoRouterState state) => const RoomCallPage()
              )
          ]
        ),
        GoRoute(
            path: "game", name: "game", builder: (context, state) => const GamePage()),
        GoRoute(path: "search_game", name: "search game", builder: (context, state) => const SearchGamePage())
      ],
    ),
  ],
);

Future<String?> getToken() async {

  try {
    
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: "token");

    if(token == null) throw 'No token';

    final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $fcmToken');
    debugPrint('APNS Token: $apnsToken');
    if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
    }

    FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      debugPrint('New FCM token: $fcmToken');
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      debugPrint('Error getting FCM token: $err');
      // Error getting token.
    });

    return token;
  } catch (e) {
    stopBackgroundService();
    rethrow;
  }
}
