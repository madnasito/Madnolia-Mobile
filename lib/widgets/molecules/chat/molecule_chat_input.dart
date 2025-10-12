import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/widgets/atoms/input/atom_chat_input.dart';
import 'package:uuid/uuid.dart';

class MoleculeChatInput extends StatefulWidget {
  final String conversation;
  final ChatMessageType messageType;
  const MoleculeChatInput({super.key, required this.conversation, required this.messageType});

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
    final backgroundService = FlutterBackgroundService();
    
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

              // final CreateMessage message = CreateMessage(conversation: widget.conversation, text: inputController.text, type: widget.messageType);

              // backgroundService.invoke("new_message",message.toJson());
              final String id = const Uuid().v4();
              backgroundService.invoke(
                "new_message", 
                CreateMessage(id: id, conversation: widget.conversation, content: inputController.text, type: ChatMessageType.user).toJson()
              );

              inputController.text = '';
            },),
      ],
    );
  }
}