import 'dart:async' show StreamSubscription;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/organism/organism_notifications.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
    late final FlutterBackgroundService _backgroundService;
    late StreamSubscription _connectionAcceptedSub;
    late StreamSubscription _connectionRejectedSub;

  @override
  void initState() {
    super.initState();
    _backgroundService = FlutterBackgroundService();
    _setupBackgroundListeners();
  }

  void _setupBackgroundListeners() {
    _connectionAcceptedSub = _backgroundService.on('connection_accepted').listen((_) {
      setState(() {
        
      });
    });
    _connectionRejectedSub = _backgroundService.on('connection_rejected').listen((_) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    _connectionAcceptedSub.cancel();
    _connectionRejectedSub.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final notificationsBloc = context.watch<NotificationsBloc>();
    notificationsBloc.add(LoadNotifications(reload: false));
    return CustomScaffold(
      body: CustomMaterialIndicator(
        autoRebuild: false,
        onRefresh: () async {
          notificationsBloc.add(RestoreNotificationsState());
          notificationsBloc.add(LoadNotifications(reload: true));
        },
        child: Column(
            children: [
              const SizedBox(height: 20),
              CenterTitleAtom(text: translate("NOTIFICATIONS.TITLE"), textStyle: neonTitleText,),
              const SizedBox(height: 10),
              Expanded(
                child: OrganismNotifications(),
              )
            ],
        ),
      )
    );
  }
}