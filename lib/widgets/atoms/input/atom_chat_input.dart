import 'package:flutter/material.dart';
class AtomChatInput extends StatelessWidget {

  final TextEditingController controller;

  const AtomChatInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
        decoration: InputDecoration(
        filled: true, // Enable the filling of the background
        fillColor: Colors.black38, // Set the desired dark background color
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        hintText: "Message",
        hintStyle: const TextStyle(color: Colors.white70), // Optional: Change hint text color
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      style: const TextStyle(color: Colors.white), // Optional: Change text color
    );
  }
}