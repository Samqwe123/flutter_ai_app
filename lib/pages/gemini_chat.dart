import 'package:e_commerce/components/ai_chat_comp.dart';
import 'package:e_commerce/models/ChatProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:provider/provider.dart';

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({Key? key}) : super(key: key);

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final TextEditingController _controller = TextEditingController();
  
  bool _isLoading = false;

  final String _apiKey = ""; // API

  List<dynamic> _products = [];

  Future<void> _loadProducts() async {
  try{
    final String response = await rootBundle.loadString('lib/assets/products.json');
    final data = json.decode(response);
    setState(() {
      _products = data;
    });
  } catch (e) {
    //print("Error loading products: $e");
  }
}
  @override
  void initState() {
      super.initState();
      _loadProducts();
    }



  Future<void> _sendMessage(String text) async {
    setState(() {
      _isLoading = true;
      Provider.of<Chatprovider>(context, listen: false).addMessage("user", text);

    });
    
    

    String productList = "Here is my store inventory:\n";
    for (var p in _products){
      productList += "${p['id']} - Price: ${p['price']} - ${p['name']}\n";
    }
    productList += "Only suggest products from this list when answering.\n";

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
            {"text": "You are a funny AI buddy who helps with shopping. Use emojis and short sentences.\n\n"
              "$productList\n\n"
              "User question: $text"},
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
