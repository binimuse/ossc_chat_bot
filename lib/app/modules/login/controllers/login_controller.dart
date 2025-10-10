import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/common/app_toasts.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {

      AppToasts.showError('Please fill in all fields');
     
      return;
    }

    if (phoneController.text.length < 10) {

      AppToasts.showError('Please enter a valid phone number');
     
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, accept any email/password
      Get.offAllNamed(Routes.HOME);

      AppToasts.showSuccess('Login successful!');

   
    } catch (e) {
      AppToasts.showError('Login failed: ${e.toString()}');
    
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() {

    AppToasts.showWarning('Password reset functionality would be implemented here');
  
  }

  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}
