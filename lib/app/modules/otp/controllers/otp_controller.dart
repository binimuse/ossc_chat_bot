import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/common/app_toasts.dart';
import 'package:ossc_chat_bot/app/routes/app_pages.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isOtpComplete = false.obs;
  final RxBool canResend = false.obs;
  final RxInt resendTimer = 60.obs;
  final RxString phoneNumber = ''.obs;
  final RxString fullName = ''.obs;
  final RxBool isRegistration = false.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    
    // Get arguments from previous screen
    final args = Get.arguments;
    if (args is Map) {
      phoneNumber.value = args['phone_number'] ?? '';
      fullName.value = args['full_name'] ?? '';
      isRegistration.value = args['is_registration'] ?? false;
    } else if (args is String) {
      // Backward compatibility for login flow
      phoneNumber.value = args;
      isRegistration.value = false;
    } else {
      phoneNumber.value = '+1234567890';
      isRegistration.value = false;
    }
    
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
      // Demo implementation - verify any 6-digit OTP
      await _verifyTelegramOtp(otpController.text);

      if (isRegistration.value) {
        AppToasts.showSuccess('Account created successfully!');
      } else {
        AppToasts.showSuccess('Login successful!');
      }
      
      // Navigate to home screen
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      AppToasts.showError('Verification failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _verifyTelegramOtp(String otpCode) async {
    // Demo implementation - simulate OTP verification
    await Future.delayed(const Duration(seconds: 2));
    
    // For demo purposes, accept any 6-digit OTP
    if (otpCode.length != 6) {
      throw Exception('OTP must be 6 digits');
    }
    
    print('Demo: OTP $otpCode verified for ${phoneNumber.value}');
  }

  void resendOtp() async {
    if (!canResend.value) return;

    isLoading.value = true;

    try {
      // Demo implementation - simulate resending OTP
      await Future.delayed(const Duration(seconds: 1));
      
      AppToasts.showSuccess('OTP resent successfully!');
      _startResendTimer();
      
      print('Demo: OTP resent to ${phoneNumber.value}');
    } catch (e) {
      AppToasts.showError('Failed to resend OTP: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }


  void changePhoneNumber() {
    Get.back();
  }
}
