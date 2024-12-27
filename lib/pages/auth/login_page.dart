import 'package:flutter/material.dart';
import 'package:madnolia/blocs/login_provider.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/organism/form/organism_form_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider.of(context);


    return const Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: OrganismFormBuilder(),
          ),
        ),
      ),
    );
  }

}
