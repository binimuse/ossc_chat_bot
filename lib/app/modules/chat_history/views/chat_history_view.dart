import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_theme.dart';

import '../controllers/chat_history_controller.dart';

class ChatHistoryView extends GetView<ChatHistoryController> {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text('Chat History', style: TextStyle(color: AppTheme.textPrimary)),
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.sessions.length,
          separatorBuilder: (_, __) => const Divider(color: AppTheme.borderColor, height: 1),
          itemBuilder: (context, index) {
            final session = controller.sessions[index];
            return ListTile(
              title: Text(session.title, style: const TextStyle(color: AppTheme.textPrimary)),
              subtitle: Text(
                session.lastUpdated.toLocal().toString(),
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
              onTap: () {
                // TODO: wire to open specific chat session
                Get.back();
              },
            );
          },
        ),
      ),
    );
  }
}


