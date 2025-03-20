import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/atoms/input/atom_chat_input.dart';

class MoleculeChatInput extends StatelessWidget {
  const MoleculeChatInput({super.key});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    
    return Row(
      children: [
        SizedBox(width: screenWidth * 0.85, child: const AtomChatInput()),
        SizedBox(
          width: screenWidth * 0.15,
          child: SizedBox.expand(
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {  },),
          ),
        )
      ],
    );
  }
}