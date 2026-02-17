import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../models/chat_message_model.dart';

class AiService {
  final _client = http.Client();

  Stream<String> getChatResponseStream(List<ChatMessage> history) async* {
    // Filter history to ensure it starts with user/system and alternates
    // Also add a system message as recommended in the curl example
    List<Map<String, dynamic>> messages = [
      {'role': 'system', 'content': 'You are a helpful assistant.'},
    ];

    for (var msg in history) {
      // Avoid sending empty messages or the initial welcome assistant message if it's the first
      if (msg.text.trim().isNotEmpty) {
        messages.add(msg.toJson());
      }
    }

    final request = http.Request('POST', Uri.parse(AppConstants.baseUrl))
      ..headers['Content-Type'] = 'application/json'
      ..headers['Authorization'] = 'Bearer ${AppConstants.aiApiKey}'
      ..body = jsonEncode({'model': AppConstants.model, 'messages': messages, 'stream': true});

    final response = await _client.send(request);

    if (response.statusCode == 200) {
      await for (final line in response.stream.transform(utf8.decoder).transform(const LineSplitter())) {
        if (line.trim().isEmpty) continue;

        if (line.startsWith('data: ')) {
          final data = line.substring(6).trim();
          if (data == '[DONE]') break;

          try {
            final json = jsonDecode(data);
            if (json['choices'] != null && json['choices'].isNotEmpty) {
              final content = json['choices'][0]['delta']['content'] as String?;
              if (content != null) {
                yield content;
              }
            }
          } catch (e) {
            // Ignore parse errors for metadata/empty deltas
          }
        }
      }
    } else {
      final errorBody = await response.stream.bytesToString();
      throw Exception('Failed to get response: ${response.statusCode} - $errorBody');
    }
  }

  Future<String> getChatResponse(List<ChatMessage> history) async {
    try {
      List<Map<String, dynamic>> messages = [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
      ];

      for (var msg in history) {
        if (msg.text.trim().isNotEmpty) {
          messages.add(msg.toJson());
        }
      }

      final response = await http.post(
        Uri.parse(AppConstants.baseUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${AppConstants.aiApiKey}'},
        body: jsonEncode({'model': AppConstants.model, 'messages': messages, 'stream': false}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        throw Exception('Failed to get response: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
