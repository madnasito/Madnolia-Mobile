import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/notifications/notifications_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';

import '../../blocs/user/user_bloc.dart';
import '../../enums/notification_type.enum.dart';
import '../atoms/notifications/atom_invitation_notification.dart';
import '../atoms/notifications/atom_request_notification.dart';

class OrganismNotifications extends StatelessWidget {
  const OrganismNotifications({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        switch (state.status) {
          
          case ListStatus.initial:
            return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
          
          case ListStatus.success:
            // Message when there is no notification
            if(state.data.isEmpty) return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.EMPTY"))));
            return NotificationsLoader();
          
          case ListStatus.failure:
            if(state.data.isEmpty) return SizedBox(height: 200, child: Center(child: Text(translate("NOTIFICATIONS.ERROR_LOADING"))));
            return NotificationsLoader();
        }
      },
    );
  }
}

class NotificationsLoader extends StatefulWidget {
  const NotificationsLoader({super.key});

  @override
  State<NotificationsLoader> createState() => _NotificationsLoaderState();
}

class _NotificationsLoaderState extends State<NotificationsLoader> {
  late final _scrollController = ScrollController();
  late final NotificationsBloc notificationsBloc;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    notificationsBloc = context.read<NotificationsBloc>();
    notificationsBloc.add(LoadNotifications());
    // notificationsBloc.add(WatchNotifications());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    final backgroundService = FlutterBackgroundService();
    
    final userBloc = context.watch<UserBloc>();
    userBloc.restoreNotifications();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: notificationsBloc.state.data.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemBuilder: (context, index) {
        final notification = notificationsBloc.state.data[index];
        return notification.type == NotificationType.request
          ? AtomRequestNotification(notification: notification)
          : AtomInvitationNotification(notification: notification, backgroundService: backgroundService);
      },
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