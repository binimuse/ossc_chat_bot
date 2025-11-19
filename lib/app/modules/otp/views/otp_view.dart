import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 4.h),

              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.telegram,
                        color: Colors.white,
                        size: 10.w,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Obx(
                      () => Text(
                        controller.isRegistration.value 
                            ? 'Verify Your Account'
                            : 'Verify Your Phone',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => Text(
                        controller.isRegistration.value
                            ? 'We sent a verification code to your Telegram'
                            : 'We sent a verification code to your Telegram',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Obx(
                      () => Text(
                        controller.phoneNumber.value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 6.h),

              // OTP Input Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: TextField(
                  controller: controller.otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                  decoration: InputDecoration(
                    hintText: '------',
                    hintStyle: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 24,
                      letterSpacing: 8,
                    ),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: controller.onOtpChanged,
                ),
              ),

              SizedBox(height: 4.h),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 7.h,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isOtpComplete.value
                        ? controller.verifyOtp
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isOtpComplete.value
                          ? AppTheme.primaryColor
                          : AppTheme.borderColor,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              // Resend Code
              Obx(
                () => TextButton(
                  onPressed: controller.canResend.value
                      ? controller.resendOtp
                      : null,
                  child: Text(
                    controller.canResend.value
                        ? 'Resend Code'
                        : 'Resend in ${controller.resendTimer.value}s',
                    style: TextStyle(
                      color: controller.canResend.value
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // Change Number
              TextButton(
                onPressed: controller.changePhoneNumber,
                child: Text(
                  'Change Phone Number',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
