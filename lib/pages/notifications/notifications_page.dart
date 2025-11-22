import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
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
    late NotificationsBloc notificationsBloc;

  @override
  void initState() {
    super.initState();
    notificationsBloc = context.read<NotificationsBloc>();
    notificationsBloc.add(LoadNotifications(reload: false));
    notificationsBloc.add(WatchNotifications());    
  }

  
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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