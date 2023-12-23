import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:toast/toast.dart';

import 'package:Madnolia/services/user_service.dart';
import 'package:Madnolia/views/platforms_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:Madnolia/widgets/form_button.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class UserPlatformsPage extends StatelessWidget {
  const UserPlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List platforms = userProvider.user.platforms;

    ToastContext().init(context);

    bool updating = false;
    return CustomScaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PlatformsView(
              platforms: platforms,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeIn(
                delay: const Duration(seconds: 1),
                child: FormButton(
                    text: "Update platforms",
                    color: Colors.transparent,
                    onPressed: updating == false
                        ? () async {
                            if (platforms.isEmpty) {
                              Toast.show(
                                  "You need to select at least one platform",
                                  gravity: 100,
                                  border: Border.all(color: Colors.blueAccent),
                                  textStyle: const TextStyle(fontSize: 18),
                                  duration: 2);
                              return;
                            }

                            updating = true;

                            final jsonBody =
                                platforms.map((platform) => platforms).toList();

                            final resp = await UserService()
                                .updateUserPlatforms(
                                    platforms: {"platforms": platforms});

                            if (resp["ok"] == true) {
                              Toast.show("Updated platforms",
                                  gravity: 100,
                                  border: Border.all(color: Colors.blueAccent),
                                  textStyle: const TextStyle(fontSize: 18),
                                  duration: 3);
                            } else {
                              Toast.show("Error updating",
                                  gravity: 100,
                                  border: Border.all(color: Colors.redAccent),
                                  textStyle: const TextStyle(fontSize: 18),
                                  duration: 3);
                            }

                            updating = false;
                          }
                        : null),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
