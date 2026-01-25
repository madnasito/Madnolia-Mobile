import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/style/button_style.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/media/animated_logo_atom.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/molecules/buttons/text_button_molecule.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: screenSize.height * 0.05,
          child: AnimatedLogoAtom(size: screenSize.width * 0.4),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 180),
              const AtomStyledText(text: "madnolia", style: mainTitleStyle),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButtonMolecule(
                    onPressed: () => context.push("/login"),
                    text: t.HEADER.LOGIN,
                    textStye: yellowTextStyle,
                    buttonStyle: borderedYellowStyle,
                  ),
                  TextButtonMolecule(
                    onPressed: () => context.push("/register"),
                    text: t.HEADER.REGISTER,
                    textStye: blueTextStyle,
                    buttonStyle: borderedBlueStyle,
                  ),
                ],
              ),
              const SizedBox(height: 80),
              AtomStyledText(
                text: t.PRESENTATION.TITLE,
                style: presentationTitle,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              AtomStyledText(
                text: t.PRESENTATION.SUBTITLE,
                style: presentationSubtitle,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
