import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/views/platforms_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/form_button.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class UserPlatformsPage extends StatelessWidget {
  const UserPlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List platforms = userProvider.user.platforms;

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
                              // TODO: Create the warning toast
                              return;
                            }

                            updating = true;
                            var jsonPlatforms =
                                json.encode({"platforms": platforms});
                            // print(jsonPlatforms);
                            final resp = await UserService()
                                .updateUserPlatforms(platforms: jsonPlatforms);

                            updating = false;
                            print(resp);
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
