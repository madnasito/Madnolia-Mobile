import 'dart:convert';

import 'package:Madnolia/services/notification_service.dart';
import 'package:Madnolia/widgets/notification_button.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/models/user_model.dart';
import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/services/sockets_service.dart';
import 'package:Madnolia/services/user_service.dart';
// import 'package:Madnolia/widgets/alert_widget.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  late SocketService socketService;
  late UserProvider userProvider;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadInfo(context, userProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScaffold(
              body: Background(
                  child: SafeArea(
                      child: Center(
                          child: Column(
            children: [
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Normal notification",
                        body: "Notification body");
                  },
                  text: "Normal Notification"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary");
                  },
                  text: "Notification with summary"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary",
                        notificationLayout: NotificationLayout.Inbox);
                  },
                  text: "Notification with summary"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary",
                        notificationLayout: NotificationLayout.ProgressBar);
                  },
                  text: "Progress bar notification"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary",
                        notificationLayout: NotificationLayout.Messaging);
                  },
                  text: "Message notification"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary",
                        notificationLayout: NotificationLayout.BigPicture,
                        bigPicture:
                            "https://media.rawg.io/media/games/b54/b542d8ff41fddb6f5dd45aa27bc293c5.jpg");
                  },
                  text: "Notification with big picture"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        summary: "Small summary",
                        payload: {"match": "658058af10301b0d09057e9c"},
                        actionButtons: []);
                  },
                  text: "Action buttons Notification"),
              NotificationButton(
                  onPressed: () async {
                    await NotificationService.showNotification(
                        title: "Title of notification",
                        body: "Body of notification",
                        scheduled: true,
                        interval: 5);
                  },
                  text: "Scheduled notification"),
            ],
          )))));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _loadInfo(BuildContext context, UserProvider user) async {
    final userInfo = await UserService().getUserInfo();

    if (userInfo["ok"] == false) {
      const storage = FlutterSecureStorage();

      await storage.delete(key: "token");
      // ignore: use_build_context_synchronously
      // showAlert(context, "Token error");
      // ignore: use_build_context_synchronously
      return context.go("/home");
    }

    user.user = userFromJson(jsonEncode(userInfo));

    return userInfo;
  }
}
