import 'package:flutter/material.dart';

final ButtonStyle borderedYellowStyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(
  horizontal: 45, vertical: 15),
  foregroundColor: Colors.pink,
  shape: const StadiumBorder(
  side: BorderSide(
    width: 2,
    color: Color.fromARGB(
      255, 255, 255, 116)
      )
    )
  );

final ButtonStyle borderedBlueStyle = TextButton.styleFrom(
                      foregroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                      horizontal: 45, vertical: 15),
                      shape: const StadiumBorder(
                        side: BorderSide(
                        color: Colors.blue, width: 2)));