import 'package:flutter/material.dart';

class Chatprovider extends ChangeNotifier {
  final List<Map<String, String>> _messages = [];

  List<Map<String, String>> getMessageList() {
    return _messages;
  }

  void addMessage(String role, String text) {
    _messages.add({"role": role, "text": text});
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }


}
