import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consult with Doctor'),
        
      ),
      body: Column(
        children: [
          // Chat message list (implemented later)
          Expanded(child: _buildChatList()),
          // Text input field
          _buildInputSection(),
        ],
     ),
    );
  }
}

Widget _buildChatList() {
  List<ChatMessage> messages = [
    // Add your message and AI response objects here
    ChatMessage(text: "Hello! How can I help you today?", sender: MessageType.AI),
  ];
  return ListView.builder(
    reverse: true, // Display newest messages at the top
    itemCount: messages.length,
    itemBuilder: (context, index) {
      return _buildMessage(messages[index]);
    },
  );
}

class ChatMessage {
  final String text;
  final MessageType sender;

  ChatMessage({required this.text, required this.sender});
}

enum MessageType { User, AI }


Widget _buildMessage(ChatMessage message) {
  return Align(
    alignment: message.sender == MessageType.User
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: message.sender == MessageType.User
            ? Colors.blue[100]
            : Colors.grey[200],
      ),
      child: Text(message.text),
    ),
  );
}

Widget _buildInputSection() {
  final TextEditingController _messageController = TextEditingController();

  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: _messageController,
          decoration: InputDecoration(hintText: 'Type your message'),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          // Add your logic to send the message to the AI and potentially update the message list
          _messageController.clear();
        },
      ),
    ],
  );
}