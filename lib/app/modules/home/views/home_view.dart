import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 4.w,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'Ossc Chat Bot',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textPrimary),
            onPressed: controller.showMenu,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat Messages Area
            Expanded(
              child: Obx(
                () => controller.messages.isEmpty
                    ? _buildWelcomeScreen()
                    : _buildChatMessages(),
              ),
            ),

            // Input Area
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                color: AppTheme.primaryColor,
                size: 40,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'How can I help you today?',
              style: Get.textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSuggestionChip('Explain quantum computing'),
                _buildSuggestionChip('Write a creative story'),
                _buildSuggestionChip('Help with coding'),
                _buildSuggestionChip('Plan a workout routine'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () => controller.sendMessage(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Text(
          text,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;
    final text = message['text'] as String;
    final isLoading = message['isLoading'] as bool? ?? false;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
            ),
            SizedBox(width: 12),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? AppTheme.primaryColor : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: isLoading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isUser ? Colors.white : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Typing...',
                          style: TextStyle(
                            color: isUser
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: isUser ? Colors.white : AppTheme.textPrimary,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.borderColor, width: 1)),
      ),
      child: Row(
        children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: TextField(
                  controller: controller.messageController,
                  style: const TextStyle(color: AppTheme.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Message ChatGPT...',
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (v) => controller.isMessageEmpty.value = v.trim().isEmpty,
                  onSubmitted: (_) => controller.sendCurrentMessage(),
                ),
              ),
            ),
            SizedBox(width: 12),
            Obx(
              () => Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: !controller.isMessageEmpty.value
                      ? AppTheme.primaryColor
                      : AppTheme.borderColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: !controller.isMessageEmpty.value
                        ? Colors.white
                        : AppTheme.textSecondary,
                    size: 20,
                  ),
                  onPressed: !controller.isMessageEmpty.value
                      ? controller.sendCurrentMessage
                      : null,
                ),
              ),
            ),
          ],
        
      ),
    );
  }
}
