import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';

class ErrorView extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;

  const ErrorView({super.key, this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 0, 25),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 15, 0, 35),
              Color.fromARGB(255, 10, 0, 25),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gamer themed icon with glow
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.videogame_asset_off_outlined,
                size: 100,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              t.ERRORS.SERVER.UNKNOWN.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              t.ERRORS.UI.MAIN,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            MoleculeFormButton(
              text: t.UTILS.RELOAD,
              onPressed: () {
                // Return to home or reset the app state
                context.go("/");
              },
            ),
            const SizedBox(height: 20),
            if (errorDetails != null)
              ExpansionTile(
                title: Text(
                  t.ERRORS.UI.TECHNICAL_DETAILS,
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    color: Colors.black26,
                    child: SingleChildScrollView(
                      child: Text(
                        errorDetails.toString(),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
