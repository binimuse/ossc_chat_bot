import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/common/app_toasts.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void registerWithTelegram() async {
    if (fullNameController.text.isEmpty || phoneController.text.isEmpty) {
      AppToasts.showError('Please fill in all fields');
      return;
    }

    if (fullNameController.text.length < 2) {
      AppToasts.showError('Please enter a valid full name');
      return;
    }

    if (phoneController.text.length < 10) {
      AppToasts.showError('Please enter a valid phone number');
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Replace with actual backend API call
      // Call your backend endpoint to send OTP via Telegram for registration
      await _sendTelegramOtpForRegistration(fullNameController.text, phoneController.text);

      // Navigate to OTP verification with phone number and full name
      Get.toNamed(Routes.OTP, arguments: {
        'phone_number': phoneController.text,
        'full_name': fullNameController.text,
        'is_registration': true,
      });

      AppToasts.showSuccess('OTP sent to your Telegram!');
      
    } catch (e) {
      AppToasts.showError('Failed to send OTP: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _sendTelegramOtpForRegistration(String fullName, String phoneNumber) async {
    // Demo implementation - simulate sending OTP for registration
    await Future.delayed(const Duration(seconds: 2));
    
    // For demo purposes, always succeed
    print('Demo: Registration OTP sent to $phoneNumber for $fullName via Telegram');
  }

  void goToLogin() {
    Get.toNamed(Routes.LOGIN);
  }
}
