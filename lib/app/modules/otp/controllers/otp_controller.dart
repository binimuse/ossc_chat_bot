import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isOtpComplete = false.obs;
  final RxBool canResend = false.obs;
  final RxInt resendTimer = 60.obs;
  final RxString phoneNumber = ''.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    // Get phone number from previous screen (you can pass it as argument)
    phoneNumber.value = Get.arguments ?? '+1234567890';
    _startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    otpController.dispose();
    super.onClose();
  }

  void _startResendTimer() {
    canResend.value = false;
    resendTimer.value = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void onOtpChanged(String value) {
    isOtpComplete.value = value.length == 6;
  }

  void verifyOtp() async {
    if (!isOtpComplete.value) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final otpCode = otpController.text;

      // For demo purposes, accept OTP "123456"
      if (otpCode == '123456') {
        Get.snackbar(
          'Success',
          'Phone verified successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to login screen
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP code. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Verification failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp() async {
    if (!canResend.value) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'OTP Sent',
        'A new verification code has been sent to ${phoneNumber.value}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reset OTP field
      otpController.clear();
      isOtpComplete.value = false;

      // Restart resend timer
      _startResendTimer();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changePhoneNumber() {
    Get.back();
  }
}
