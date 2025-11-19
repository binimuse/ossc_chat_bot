import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/common/app_toasts.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;


  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void loginWithTelegram() async {
    if (phoneController.text.isEmpty) {
      AppToasts.showError('Please enter your phone number');
      return;
    }

    if (phoneController.text.length < 10) {
      AppToasts.showError('Please enter a valid phone number');
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Replace with actual backend API call
      // Call your backend endpoint to send OTP via Telegram
      await _sendTelegramOtp(phoneController.text);

      // Navigate to OTP verification screen
      Get.toNamed(Routes.OTP, arguments: phoneController.text);
      
    } catch (e) {
      AppToasts.showError('Failed to send OTP: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _sendTelegramOtp(String phoneNumber) async {
    // Demo implementation - simulate sending OTP
    await Future.delayed(const Duration(seconds: 2));
    
    // For demo purposes, always succeed
    print('Demo: OTP sent to $phoneNumber via Telegram');
  }

  void forgotPassword() {

    AppToasts.showWarning('Password reset functionality would be implemented here');
  
  }

  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}
