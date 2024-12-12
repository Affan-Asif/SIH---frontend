import 'package:flutter/material.dart';

class ChatboxScreen extends StatefulWidget {
  const ChatboxScreen({super.key});

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"sender": "system", "message": "Hello! How can I assist you today with post office tasks?"},
  ];

  // Sample responses based on keywords in the employee's message
  String _getSystemResponse(String query) {
    if (query.contains("parcel")) {
      return "The delivery for parcel #12345 is on its way and should arrive by 5 PM today.";
    } else if (query.contains("schedule")) {
      return "Your shift is from 9 AM to 5 PM. Would you like to view your full schedule?";
    } else {
      return "I'm sorry, I couldn't find information on that. Please try another query.";
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // Send employee's message
      setState(() {
        _messages.add({"sender": "employee", "message": _controller.text});
      });

      // Get system's response after employee's message is sent
      String response = _getSystemResponse(_controller.text);

      // Send system's response
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add({"sender": "system", "message": response});
        });
      });

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbox'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Message feed section
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageTile(
                  _messages[index]['sender']!,
                  _messages[index]['message']!,
                );
              },
            ),
          ),

          // Input section with send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(String sender, String message) {
    bool isSystemMessage = sender == "system";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: isSystemMessage ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSystemMessage ? const Color.fromARGB(255, 178, 208, 230) : const Color.fromARGB(255, 143, 199, 148),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isSystemMessage ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
