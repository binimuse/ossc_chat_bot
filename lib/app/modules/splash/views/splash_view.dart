import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ossc_chat_bot/app/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar to primary color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff37A0F4), // AppColors.primary
        statusBarIconBrightness: Brightness.dark, // Black text/icons
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main Content
          Center(
            child: SizedBox(
              child: Image.asset(
                controller.appLogo,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // Bottom Text - "SWIPE UP" from Figma
        ],
      ),
    );
  }
}
