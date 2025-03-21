import 'package:flutter/material.dart';
import 'package:madnolia/widgets/atoms/input/atom_chat_input.dart';

class MoleculeChatInput extends StatefulWidget {
  const MoleculeChatInput({super.key});

  @override
  State<MoleculeChatInput> createState() => _MoleculeChatInputState();
}

class _MoleculeChatInputState extends State<MoleculeChatInput> {

  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field
    inputController.addListener(() {
      setState(() {}); // Call setState to rebuild the widget when text changes
    });
  }

  @override
  void dispose() {
    inputController.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    
    return Wrap(
      children: [
        SizedBox(width: screenWidth * 0.85, child: AtomChatInput(controller: inputController)),
        IconButton(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(9),
          ),
            icon: Icon(Icons.send, color: inputController.text.isEmpty ? Colors.grey : Colors.blue),
            onPressed: () {
              
              if(inputController.text.isEmpty) return;

              inputController.text = '';
            },),
        
      ],
    );
  }
}