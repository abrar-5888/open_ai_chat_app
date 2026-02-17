import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/chat_message_model.dart';
import '../../../data/services/ai_service.dart';

class ChatController extends GetxController {
  final AiService _aiService = AiService();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Welcome message (Local only, formatted with a special flag or just skipped in API service)
    messages.add(ChatMessage(text: "Hello! I am your AI assistant powered by SambaNova. How can I help you today?", isUser: false, timestamp: DateTime.now()));
  }

  void sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();
    messages.add(ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));

    _scrollToBottom();

    isLoading.value = true;

    try {
      // Create an empty AI message to fill with stream
      final aiMessage = ChatMessage(text: "", isUser: false, timestamp: DateTime.now());
      messages.add(aiMessage);

      // Filter history to ONLY include messages that should go to the API
      // We skip the very first welcome message if it's the welcome one
      final apiHistory = messages.sublist(1, messages.length - 1);

      await for (final chunk in _aiService.getChatResponseStream(apiHistory)) {
        if (isLoading.value) isLoading.value = false;
        aiMessage.text += chunk;
        messages.refresh();
        _scrollToBottom();
      }
    } catch (e) {
      print("Error in streaming: $e");
      // If error occurs, remove the empty AI message we added
      if (messages.isNotEmpty && messages.last.text.isEmpty) {
        messages.removeLast();
      }
      Get.snackbar(
        "Service Error",
        "API error: ${e.toString().split('-').last.trim()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withAlpha(204),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
