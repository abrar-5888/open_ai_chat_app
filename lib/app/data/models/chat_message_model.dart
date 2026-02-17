class ChatMessage {
  String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {'role': isUser ? 'user' : 'assistant', 'content': text};
  }
}
