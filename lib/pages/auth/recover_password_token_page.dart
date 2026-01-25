import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/services/user_service.dart';

import '../../widgets/organism/form/organism_recover_password_token_form.dart';

class RecoverPasswordTokenPage extends StatelessWidget {
  final String token;
  const RecoverPasswordTokenPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: UserService().getUserInfoByExternalToken(token: token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      snapshot.data!.image,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  t.UTILS.RECOVERING_PASSWORD_FOR(name: snapshot.data!.name),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 15),
                OrganismRecoverPasswordTokenForm(token: token),
              ],
            );
          } else if (snapshot.hasError) {
            Timer(const Duration(seconds: 3), () {
              debugPrint('Redirecting to home page');
              context.go('/');
            });
            return SizedBox(
              height:
                  MediaQuery.of(context).size.height / 2 -
                  MediaQuery.of(context).padding.vertical,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.RECOVER_PASSWORD.ERROR_GETTING_INFO,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.RECOVER_PASSWORD.HOME_PAGE_REDIRECTING,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
