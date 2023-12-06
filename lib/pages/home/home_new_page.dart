import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/background.dart';
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
                                child: const Text(
                                  "Login",
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
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ])),
                  const Text(
                    "Connect with gamers around the world",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Create matches for any retro or modern platform",
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
