import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_theme.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text('Settings', style: TextStyle(color: AppTheme.textPrimary)),
      ),
      body: ListView(
        children: [
          Obx(() => SwitchListTile(
                title: const Text('Dark Mode', style: TextStyle(color: AppTheme.textPrimary)),
                subtitle: const Text('Use dark theme', style: TextStyle(color: AppTheme.textSecondary)),
                value: controller.darkMode.value,
                activeColor: AppTheme.primaryColor,
                onChanged: (v) => controller.darkMode.value = v,
              )),
          const Divider(color: AppTheme.borderColor, height: 1),
          Obx(() => SwitchListTile(
                title: const Text('Notifications', style: TextStyle(color: AppTheme.textPrimary)),
                subtitle: const Text('Enable app notifications', style: TextStyle(color: AppTheme.textSecondary)),
                value: controller.notificationsEnabled.value,
                activeColor: AppTheme.primaryColor,
                onChanged: (v) => controller.notificationsEnabled.value = v,
              )),
          const Divider(color: AppTheme.borderColor, height: 1),
          ListTile(
            title: const Text('About', style: TextStyle(color: AppTheme.textPrimary)),
            subtitle: const Text('Ossc Chat Bot', style: TextStyle(color: AppTheme.textSecondary)),
            trailing: const Icon(Icons.info_outline, color: AppTheme.textSecondary),
            onTap: () {
              Get.dialog(AlertDialog(
                backgroundColor: AppTheme.surfaceColor,
                title: const Text('About', style: TextStyle(color: AppTheme.textPrimary)),
                content: const Text('Ossc Chat Bot - v1.0.0', style: TextStyle(color: AppTheme.textSecondary)),
                actions: [
                  TextButton(onPressed: () => Get.back(), child: const Text('Close')),
                ],
              ));
            },
          ),
        ],
      ),
    );
  }
}


