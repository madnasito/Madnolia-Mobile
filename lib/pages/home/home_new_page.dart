
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/style/button_style.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/animated_logo_atom.dart';
import 'package:madnolia/widgets/atoms/text_atoms/styled_text_atom.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/molecules/buttons/text_button_molecule.dart';
import 'package:madnolia/widgets/super_cube.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;


    return Background(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: screenSize.height * 0.05,
                child: AnimatedLogoAtom(size: screenSize.width * 0.4)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 60),
                  Center(
                      heightFactor: 3,
                      child: Column(children: [
                        const StyledTextAtom(
                          text: "madnolia",
                          style: mainTitleStyle,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButtonMolecule(
                              onPressed: () => context.go("/login"),
                              text: translate("HEADER.LOGIN"),
                              textStye: yellowTextStyle,
                              buttonStyle: borderedYellowStyle
                            ),
   //                         context.go("/register")
// translate("HEADER.REGISTER")
                            TextButtonMolecule(
                              onPressed: () => context.go("/register"),
                              text: translate("HEADER.REGISTER"),
                              textStye: blueTextStyle,
                              buttonStyle: borderedBlueStyle
                            )
                          ],
                        )
                      ])),
                  Text(
                    translate("PRESENTATION.TITLE"),
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    translate("PRESENTATION.SUBTITLE"),
                    style: const TextStyle(
                        color: Colors.white70,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
