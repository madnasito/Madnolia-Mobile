import 'package:madnolia/models/auth/register_model.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:madnolia/widgets/organism/form/organism_register_form.dart';
import 'package:madnolia/widgets/organism/form/organism_select_platform.dart' show OrganismSelectPlatform;
import 'package:madnolia/widgets/background.dart';

bool canScroll = false;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  final RegisterModel registerModel =
      RegisterModel(email: "", name: "", password: "", platforms: [], username: "");
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    canScroll = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final PageController controller =  PageController(
      keepPage: true,);
    return Scaffold(
        body: Background(
          child: SafeArea(
            child: PageView(
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                if(!canScroll) controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Easing.linear);
                
              },
              controller: controller,
              children: [
                FadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 0.0),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.of(context).maybePop(),
                            ),
                          ),
                          OrganismRegisterForm(
                            registerModel: widget.registerModel,
                            controller: controller,
                            changeScroll: (value) => canScroll = value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeIn(child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Easing.linear),
                            ),
                          ),
                      OrganismSelectPlatform(registerModel: widget.registerModel),
                    ],
                  )
                ))
              ],
            )
          )
        ),
    );
  }

  
}

