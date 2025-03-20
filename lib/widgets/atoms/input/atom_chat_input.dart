import 'package:flutter/material.dart';

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.blue));

class AtomChatInput extends StatelessWidget {
  const AtomChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField( 
      decoration: InputDecoration(
        hintText: "Message",
        focusedBorder: focusedBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blue, width: 3),
              )
      ),
    );
  }
}