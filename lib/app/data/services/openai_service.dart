import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../models/chat_message_model.dart';

class OpenAiService {
  Future<String> getChatResponse(List<ChatMessage> history) async {
    try {
      final messages = history.map((e) => e.toJson()).toList();

      final response = await http.post(
        Uri.parse(AppConstants.baseUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${AppConstants.aiApiKey}'},
        body: jsonEncode({'model': AppConstants.model, 'messages': messages}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        throw Exception('Failed to get response: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
