import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/database/providers/friendship_db.dart';
import 'package:madnolia/database/providers/user_db.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/widgets/background.dart';

// import 'package:madnolia/widgets/form_button.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    
    final userBloc = context.read<UserBloc>();
    final messageBloc = context.read<MessageBloc>();
    
    final backgroundService = FlutterBackgroundService();

    backgroundService.on("new_request_connection").listen((onData) {
      if(onData?['user'] == userBloc.state.id) userBloc.updateNotifications(userBloc.state.notifications + 1);
    });
    backgroundService.on("invitation").listen((onData) => userBloc.updateNotifications(userBloc.state.notifications + 1));
    
    return Scaffold(
      drawer: Drawer(
        surfaceTintColor: Colors.pink,
        backgroundColor: const Color.fromARGB(96, 9, 4, 24),
        child: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => GoRouter.of(context).pushReplacement("/me/edit"),
                child: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const SizedBox(width: 0),
                    CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(userBloc.state.img),
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
                    icon: Icon(Icons.bolt_outlined, size: 40,color: Colors.white),
                    title: translate("HEADER.MATCH"),
                    route: "/new",
                  ),
                  _MenuButton(
                    icon: Icon(CupertinoIcons.gamecontroller, size: 40, color: Colors.white),
                    title: translate('MATCHES.TITLE'),
                    route: "/matches",
                  ),
                  _MenuButton(
                    icon: userBloc.state.notifications == 0 ? Icon(Icons.notifications_none_rounded,size: 40, color: Colors.white ) : Stack(
                      alignment: Alignment.center,
                      children: [
                      Icon(Icons.notifications_active_rounded,size: 40, color: Colors.pink ),
                      Text(userBloc.state.notifications > 9 ? '9+' : userBloc.state.notifications.toString(), style: TextStyle(color: Colors.white, fontSize: 14))
                    ] 
                    ),
                    title:
                        translate("HEADER.NOTIFICATIONS"),
                    route: "/notifications",
                  ),
                  _MenuButton(
                    icon: messageBloc.state.unreadUserChats == 0 ? Icon(Icons.chat_bubble_outline_rounded,size: 40, color: Colors.white ) : Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.chat_bubble_rounded,size: 40, color: Colors.pink ),
                        Positioned(
                          bottom: 12,
                          child: Text(messageBloc.state.unreadUserChats > 9 ? '9+' : messageBloc.state.unreadUserChats.toString(), style: TextStyle(color: Colors.white, fontSize: 14)))
                      ] 
                    ),
                    title: "Chat",
                    route: "/chat",
                  ),
                  // _MenuButton(
                  //     icon: Icons.groups_2_outlined,
                  //     title: translate("HEADER.PROFILE"),
                  //     route: "/user"),
                  _MenuButton(
                      icon: Icon(Icons.person_outline_outlined, size: 40, color: Colors.white),
                      title: translate("HEADER.PROFILE"),
                      route: "/me"),
                  const SizedBox(height: 230),
                ],
              ),
              Positioned(
                  bottom: 30,
                  left: 20,
                  child: GestureDetector(
                    onTap: () async {
                      final chatsBloc = context.read<ChatsBloc>();
                      final matchesBloc = context.read<PlayerMatchesBloc>();
                      userBloc.logOutUser();
                      messageBloc.add(RestoreState());
                      matchesBloc.add(RestoreMatchesState());
                      chatsBloc.add(RestoreUserChats());
                      backgroundService.invoke("delete_all_notifications");
                      // backgroundService.invoke("stop");
                      stopBackgroundService();
                      const storage = FlutterSecureStorage();
                      await storage.delete(key: "token");
                      if(!context.mounted) return;
                      UserProvider.clearTable();
                      FriendshipProvider.deleteAll();
                      GoRouter.of(context).pushReplacement("/home");
                    },
                    child: const Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                          size: 30,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: IconButton(
            icon: SvgPicture.asset("assets/madnolia-logo.svg",
            width: MediaQuery.of(context).size.width / 11,),
            onPressed: () => GoRouter.of(context).pushReplacement("/")),
        actions: [
          IconButton(
            onPressed: (){
              changeRoute(context, '/search');
            },
            icon: const Icon(Icons.search_rounded)
            )
        ],
      ),
      body: Background(
        child: SafeArea(
          child: body
        )
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final String route;
  const _MenuButton(
      {required this.icon, required this.title, required this.route});

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
              icon,
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
void changeRoute(BuildContext context, String route){
  final currentRouteName = "/${ModalRoute.of(context)?.settings.name}";
  if (route != "" && route != currentRouteName) {
    GoRouter.of(context).pushReplacement(route);
  }
}
