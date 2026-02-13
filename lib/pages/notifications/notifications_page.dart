import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/organism/organism_notifications.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationsBloc notificationsBloc;
  late final _scrollController = ScrollController();

  final backgroundService = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();
    notificationsBloc = context.read<NotificationsBloc>();
    notificationsBloc.add(LoadNotifications());
    notificationsBloc.add(WatchNotifications());
    _scrollController.addListener(_onScroll);
    backgroundService.invoke('read_all_notifications');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      autoRebuild: false,
      onRefresh: () async {
        notificationsBloc.add(RestoreNotificationsState());
        notificationsBloc.add(LoadNotifications(reload: true));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CenterTitleAtom(
              text: t.NOTIFICATIONS.TITLE,
              textStyle: neonTitleText,
            ),
            const SizedBox(height: 10),
            const OrganismNotifications(),
          ],
        ),
      ),
    );
  }

  void _onScroll() {
    debugPrint('Is bottom: $_isBottom');
    if (_isBottom) {
      notificationsBloc.add(LoadNotifications());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }
}
