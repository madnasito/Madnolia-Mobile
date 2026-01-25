import 'dart:ui';

import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:madnolia/blocs/blocs.dart';

import '../../../routes/routes.dart' show router;
import '../../../utils/logout.dart';

import '../../molecules/buttons/atom_menu_button.dart';
import '../../molecules/molecule_menu_avatar.dart';

class OrganismDrawer extends StatelessWidget {
  const OrganismDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final messageBloc = context.read<MessageBloc>();
    return Drawer(
      surfaceTintColor: Colors.pink,
      backgroundColor: Colors.transparent, // Cambia a transparente
      child: Stack(
        children: [
          // Fondo con blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black54, // Color semitransparente
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 15),
                  child: MoleculeMenuAvatar(userBloc: userBloc),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AtomMenuButton(
                      icon: Icon(
                        Icons.bolt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      title: t.HEADER.MATCH,
                      route: "/new",
                    ),
                    AtomMenuButton(
                      icon: Icon(
                        CupertinoIcons.gamecontroller,
                        size: 40,
                        color: Colors.white,
                      ),
                      title: t.MATCHES.TITLE,
                      route: "/matches",
                    ),
                    AtomMenuButton(
                      icon: userBloc.state.notifications == 0
                          ? Icon(
                              Icons.notifications_none_rounded,
                              size: 40,
                              color: Colors.white,
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_active_rounded,
                                  size: 40,
                                  color: Colors.pink,
                                ),
                                Text(
                                  userBloc.state.notifications > 9
                                      ? '9+'
                                      : userBloc.state.notifications.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                      title: t.HEADER.NOTIFICATIONS,
                      route: "/notifications",
                    ),
                    AtomMenuButton(
                      icon: messageBloc.state.unreadUserChats == 0
                          ? Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 40,
                              color: Colors.white,
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_rounded,
                                  size: 40,
                                  color: Colors.pink,
                                ),
                                Positioned(
                                  bottom: 12,
                                  child: Text(
                                    messageBloc.state.unreadUserChats > 9
                                        ? '9+'
                                        : messageBloc.state.unreadUserChats
                                              .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      title: "Chat",
                      route: "/chat",
                    ),
                    AtomMenuButton(
                      icon: Icon(
                        Icons.person_outline_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      title: t.HEADER.PROFILE,
                      route: "/me",
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  margin: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () async {
                      final scaffoldState = Scaffold.maybeOf(context);
                      if (scaffoldState != null && scaffoldState.isDrawerOpen) {
                        scaffoldState.closeDrawer();
                      }
                      await logoutApp(context);
                      router.go("/");
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          t.HEADER.LOGOUT,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
