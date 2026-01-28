import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/molecules/buttons/atom_menu_button.dart'
    show changeRoute;
import 'package:madnolia/widgets/organism/menu/organism_drawer.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  final Widget? floatingActionButton;
  const CustomScaffold({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  StreamSubscription? _newRequestSubscription;
  StreamSubscription? _invitationSubscription;

  @override
  void initState() {
    super.initState();
    _setupBackgroundListeners();
  }

  void _setupBackgroundListeners() {
    final backgroundService = FlutterBackgroundService();

    _newRequestSubscription = backgroundService
        .on("new_request_connection")
        .listen((onData) {
          if (mounted) {
            final userBloc = context.read<UserBloc>();
            if (onData?['user'] == userBloc.state.id) {
              userBloc.add(
                AddNotifications(value: userBloc.state.notifications + 1),
              );
            }
          }
        });

    _invitationSubscription = backgroundService.on("invitation").listen((
      onData,
    ) {
      if (mounted) {
        final userBloc = context.read<UserBloc>();
        userBloc.add(AddNotifications(value: userBloc.state.notifications + 1));
      }
    });
  }

  @override
  void dispose() {
    _newRequestSubscription?.cancel();
    _invitationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocaleSettings.useDeviceLocale();

    final userBloc = context.watch<UserBloc>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: userBloc.state.loadedUser ? const OrganismDrawer() : null,
      drawerEnableOpenDragGesture: false,
      appBar: userBloc.state.loadedUser
          ? AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: userBloc.state.loadedUser
                        ? () {
                            Scaffold.of(context).openDrawer();
                          }
                        : null,
                  );
                },
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              centerTitle: true,
              title: IconButton(
                icon: SvgPicture.asset(
                  "assets/madnolia-logo.svg",
                  width: MediaQuery.of(context).size.width / 11,
                ),
                onPressed: () {
                  final String? currentRoute = GoRouterState.of(
                    context,
                  ).fullPath;

                  if (currentRoute != '/') GoRouter.of(context).go("/");
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    changeRoute(context, '/search');
                  },
                  icon: const Icon(Icons.search_rounded),
                ),
              ],
            )
          : null,
      floatingActionButton: userBloc.state.loadedUser
          ? widget.floatingActionButton
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: SafeArea(child: widget.child),
    );
  }
}
