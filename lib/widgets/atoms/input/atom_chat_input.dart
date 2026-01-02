import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
class AtomChatInput extends StatelessWidget {

  final TextEditingController controller;

  const AtomChatInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
        decoration: InputDecoration(
        filled: true, // Enable the filling of the background
        fillColor: const Color.fromARGB(12, 255, 255, 255), // Set the desired dark background color
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        hintText: t.CHAT.MESSAGE,
        hintStyle: const TextStyle(color: Colors.white70), // Optional: Change hint text color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
          gapPadding: 4
        ),
      ),
      style: const TextStyle(color: Colors.white), // Optional: Change text color
    );
  }
}