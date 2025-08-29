import 'package:e_commerce/components/ai_chat_comp.dart';
import 'package:e_commerce/models/ChatProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({Key? key}) : super(key: key);

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final TextEditingController _controller = TextEditingController();
  
  bool _isLoading = false;

  final String _apiKey = "abatukam"; // API

  Future<void> _sendMessage(String text) async {
    setState(() {
      _isLoading = true;
      Provider.of<Chatprovider>(context, listen: false).addMessage("user", text);

    });
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent",
    );
    final headers = {
      "x-goog-api-key": _apiKey,
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": text},
          ],
        },
      ],
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String aiText =
            data["candidates"]?[0]["content"]?["parts"]?[0]["text"] ??
            "No response";
            Provider.of<Chatprovider>(context, listen: false).addMessage("ai", aiText);
        
      } else {
        Provider.of<Chatprovider>(context, listen: false).addMessage("ai","Error: ${response.statusCode}" );
        
      }
    } catch (e) {
      Provider.of<Chatprovider>(context, listen: false).addMessage("ai","Error: $e" );
      
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatprovider>(builder: (context, value, child) {
      return aiChatComp(
      isLoading: _isLoading,
      controller: _controller,
      messages: value.getMessageList(),
      onSendMessage: _sendMessage,
    );  
    });
  }
}
