import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/common/app_toasts.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void register() async {
    if (fullNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppToasts.showError('Please fill in all fields');
     
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {

      AppToasts.showError('Passwords do not match');
    
      return;
    }

    if (passwordController.text.length < 6) {

      AppToasts.showError('Password must be at least 6 characters');
     
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

      // Navigate to OTP verification with phone number
      Get.offAllNamed(Routes.OTP, arguments: phoneController.text);

      AppToasts.showSuccess('Account created successfully!');
    
    } catch (e) {

      AppToasts.showError('Registration failed: ${e.toString()}');
     
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.toNamed(Routes.LOGIN);
  }
}
