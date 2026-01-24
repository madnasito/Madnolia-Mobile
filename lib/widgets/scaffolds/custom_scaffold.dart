import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/molecules/buttons/atom_menu_button.dart' show changeRoute;
import 'package:madnolia/widgets/organism/menu/organism_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  const CustomScaffold({super.key, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {

    LocaleSettings.useDeviceLocale();
    
    final userBloc = context.watch<UserBloc>();
    
    final backgroundService = FlutterBackgroundService();

    backgroundService.on("new_request_connection").listen((onData) {
      if(onData?['user'] == userBloc.state.id) userBloc.add(AddNotifications(value: userBloc.state.notifications + 1));
    });
    backgroundService.on("invitation").listen((onData) => userBloc.add(AddNotifications(value: userBloc.state.notifications + 1)));
    return Scaffold(
      drawer: OrganismDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: userBloc.state.loadedUser ? () {
                Scaffold.of(context).openDrawer();
              } : null,
            );
          }
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: IconButton(
            icon: SvgPicture.asset("assets/madnolia-logo.svg",
            width: MediaQuery.of(context).size.width / 11,),
            onPressed: () {
              final String? currentRoute = GoRouterState.of(context).fullPath;

              if(currentRoute != '/') GoRouter.of(context).push("/");
            } 
            )
            ,
        actions: [
          IconButton(
            onPressed: (){
              changeRoute(context, '/search');
            },
            icon: const Icon(Icons.search_rounded)
            )
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Background(
        child: SafeArea(
          child: body
        )
      ),
    );
  }
}


