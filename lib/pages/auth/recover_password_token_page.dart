import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/scaffolds/unloged_scaffold.dart';

import '../../widgets/organism/form/organism_recover_password_token_form.dart';

class RecoverPasswordTokenPage extends StatelessWidget {
  final String token;
  const RecoverPasswordTokenPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return UnlogedScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: UserService().getUserInfoByExternalToken(token: token),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(snapshot.data!.image),
                      )
                    ),
                  SizedBox(height: 15),
                  Text('Recovering password for ${snapshot.data?.name}', 
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  const SizedBox(height: 15),
                  OrganismRecoverPasswordTokenForm(token: token)
                ],
              );
            }
            else if(snapshot.hasError) {
              Timer(const Duration(seconds: 3), () {
                debugPrint('Redirecting to home page');
                context.go('/');
              });
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).padding.vertical,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        translate('RECOVER_PASSWORD.ERROR_GETTING_INFO'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        translate('RECOVER_PASSWORD.HOME_PAGE_REDIRECTING'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }else {

              return Center(child: CircularProgressIndicator.adaptive());
            }
             
          }
        ),
      )
    );
  }
}