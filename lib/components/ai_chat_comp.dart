import 'package:e_commerce/models/ChatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class aiChatComp extends StatelessWidget {
  List<Map<String, String>> messages;
  bool isLoading;
  TextEditingController controller;
  final Function(String) onSendMessage;

  //constructor
  aiChatComp({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.controller,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          if (messages.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "Start the conversation by typing below.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: msg["role"] == "user"
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: msg["role"] == "user"
                                  ? const Color.fromARGB(255, 138, 187, 222)
                                  : const Color.fromARGB(255, 110, 231, 120),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(msg["text"] ?? ""),
                                SizedBox(height: 4),
                                Text(
                                  msg["role"] == "user" ? "You" : "your AI",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12,)
                    ],
                  );
                },
              ),
            ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(context: context,builder: (context) => AlertDialog(
                      title: Text("Clear Chat"),
                      content: Text("Are you sure you want to clear the chat?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Provider.of<Chatprovider>(context, listen: false).clearMessages();
                          },
                          child: Text("Clear"),
                        ),
                      ],
                    ));
                    
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isLoading
                      ? null
                      : () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            controller.clear();
                            onSendMessage(text);
                          }
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
