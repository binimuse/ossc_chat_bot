import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isMessageEmpty = true.obs;

  // OpenAI client (you'll need to add your API key)
  late OpenAIClient openAI;

  @override
  void onInit() {
    super.onInit();
    // Initialize OpenAI client with your API key
    // openAI = OpenAIClient(apiKey: 'your-api-key-here');

    // Listen to message controller changes
    messageController.addListener(() {
      isMessageEmpty.value = messageController.text.trim().isEmpty;
      update();
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void sendMessage(String message) {
    messageController.text = message;
    sendCurrentMessage();
  }

  void sendCurrentMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    messages.add({'isUser': true, 'text': text, 'timestamp': DateTime.now()});

    // Clear input
    messageController.clear();

    // Add loading message
    final loadingMessageIndex = messages.length;
    messages.add({
      'isUser': false,
      'text': '',
      'isLoading': true,
      'timestamp': DateTime.now(),
    });

    try {
      // Simulate AI response (replace with actual OpenAI API call)
      await Future.delayed(const Duration(seconds: 2));

      // Remove loading message
      messages.removeAt(loadingMessageIndex);

      // Add AI response
      final aiResponse = _generateMockResponse(text);
      messages.add({
        'isUser': false,
        'text': aiResponse,
        'timestamp': DateTime.now(),
      });

      // Scroll to bottom
      await Future.delayed(const Duration(milliseconds: 100));
      // You can add scroll controller here if needed
    } catch (e) {
      // Remove loading message
      messages.removeAt(loadingMessageIndex);

      // Add error message
      messages.add({
        'isUser': false,
        'text': 'Sorry, I encountered an error. Please try again.',
        'timestamp': DateTime.now(),
      });
    }
  }

  String _generateMockResponse(String userMessage) {
    // Mock responses for demonstration
    final responses = [
      'That\'s an interesting question! Let me help you with that.',
      'I understand what you\'re asking. Here\'s what I think...',
      'Great question! Based on my knowledge, I can suggest the following:',
      'I\'d be happy to help you with that. Let me provide some insights.',
      'That\'s a fascinating topic! Here are some thoughts on the matter:',
    ];

    // Simple keyword-based responses
    if (userMessage.toLowerCase().contains('hello') ||
        userMessage.toLowerCase().contains('hi')) {
      return 'Hello! How can I assist you today?';
    } else if (userMessage.toLowerCase().contains('code') ||
        userMessage.toLowerCase().contains('programming')) {
      return 'I\'d be happy to help you with coding! What programming language or concept would you like to work on?';
    } else if (userMessage.toLowerCase().contains('story') ||
        userMessage.toLowerCase().contains('creative')) {
      return 'I love creative writing! What kind of story would you like me to help you with?';
    } else if (userMessage.toLowerCase().contains('quantum')) {
      return 'Quantum computing is fascinating! It\'s a type of computation that uses quantum mechanical phenomena to process information. Would you like me to explain any specific aspects?';
    } else if (userMessage.toLowerCase().contains('workout') ||
        userMessage.toLowerCase().contains('exercise')) {
      return 'I can help you create a workout plan! What are your fitness goals and current level?';
    }

    return responses[DateTime.now().millisecond % responses.length];
  }

  void showMenu() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF2F2F2F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_comment, color: Colors.white),
              title: const Text(
                'New Chat',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                messages.clear();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white),
              title: const Text(
                'Chat History',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.CHAT_HISTORY);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.SETTINGS);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2F2F2F),
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Clear messages
              messages.clear();
              // Navigate to login
              Get.offAllNamed(Routes.LOGIN);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Method to integrate with OpenAI API (commented out for now)
  /*
  Future<String> _getOpenAIResponse(String message) async {
    try {
      final response = await openAI.chat.create(
        request: CreateChatCompletionRequest(
          model: 'gpt-3.5-turbo',
          messages: [
            ChatCompletionMessage(
              role: ChatCompletionRole.user,
              content: message,
            ),
          ],
        ),
      );
      
      return response.choices.first.message.content ?? 'Sorry, I couldn\'t generate a response.';
    } catch (e) {
      throw Exception('Failed to get AI response: $e');
    }
  }
  */
}
