import 'package:flutter/material.dart';

const TextStyle mainTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: "Cyberverse",
  decoration: TextDecoration.none,
  fontWeight: FontWeight.normal
);

const TextStyle yellowTextStyle = TextStyle(
  color: Color.fromARGB(255, 255, 255, 122)
);

const TextStyle blueTextStyle = TextStyle(
  color: Colors.blue
);

const TextStyle presentationTitle = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 20);

const TextStyle presentationSubtitle = TextStyle(
  color: Colors.white70,
  decoration: TextDecoration.none,
  fontSize: 15);

const TextStyle neonTitleText = TextStyle(
  fontSize: 30,
  fontFamily: "Cyberverse",
  decoration: TextDecoration.none,
  fontWeight: FontWeight.normal,
  shadows: [
    // Sombra principal para el brillo neón (ajusta el color y blurRadius)
    Shadow(
      blurRadius: 2.0,
      color: Color(0xFF00FFFF), // Un color cian brillante es un clásico neón
      offset: Offset(0, 0),
    ),
    // Opcional: una segunda sombra más difusa para un mejor efecto
    Shadow(
      blurRadius: 4.0,
      color: Color(0xFF00FFFF),
      offset: Offset(0, 0),
    ),
  ],
);
