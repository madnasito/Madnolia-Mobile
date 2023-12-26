import 'package:Madnolia/main.dart';
import 'package:Madnolia/widgets/language_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/super_cube.dart';
import 'package:multi_language_json/multi_language_json.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    LangSupport langData = LanguageBuilder.langData;

    return Background(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: screenSize.height * 0.05,
                child: SuperCube(size: screenSize.width * 0.4)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 60),
                  Center(
                      heightFactor: 3,
                      child: Column(children: [
                        const Text(
                          "Madnolia",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Cyberverse",
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.pink,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 255, 255, 116))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 45, vertical: 15)),
                                onPressed: () => context.go("/login"),
                                child: Text(
                                  langData.getValue(route: ["HEADER", "LOGIN"]),
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 122)),
                                )),
                            TextButton(
                              onPressed: () => context.go("/register"),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 15),
                                  shape: const StadiumBorder(
                                      side: BorderSide(
                                          color: Colors.blue, width: 2))),
                              child: Text(
                                langData
                                    .getValue(route: ["HEADER", "REGISTER"]),
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ])),
                  Text(
                    langData.getValue(route: ["PRESENTATION", "TITLE"]),
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    langData.getValue(route: ["PRESENTATION", "SUBTITLE"]),
                    style: TextStyle(
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
