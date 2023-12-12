import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/user_model.dart';
import 'package:madnolia/providers/user_provider.dart';
import 'package:madnolia/services/sockets_service.dart';
import 'package:madnolia/services/user_service.dart';
// import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

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
                      child: Center(child: Text(userProvider.user.name)))));
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
