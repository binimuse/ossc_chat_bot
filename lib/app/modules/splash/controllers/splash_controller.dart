import 'package:get/get.dart';

import 'package:ossc_chat_bot/app/routes/app_pages.dart';
import 'package:ossc_chat_bot/app/utils/auth_util.dart';
import 'package:ossc_chat_bot/gen/assets.gen.dart';

class SplashController extends GetxController {
  final String appName = 'AscheMart';
  final String appLogo = Assets.logos.logo.path;

  @override
  void onInit() {
    super.onInit();
    _checkAuthenticationAndNavigate();
  }

  void _checkAuthenticationAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      print('=== Splash: Checking authentication status ===');

      // Debug token status
      await AuthUtil().debugTokenStatus();

      // Check if user is authenticated
      bool isAuthenticated = await AuthUtil().isFullyAuthenticated();

      print('Splash: Authentication check result: $isAuthenticated');

      if (isAuthenticated) {
        // User is logged in, navigate to main page
        print('Splash: User is authenticated, navigating to main page');
        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        // User is not logged in, navigate to onboarding
        print('Splash: User is not authenticated, navigating to onboarding');
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      print('Splash: Error checking authentication: $e');
      // In case of error, navigate to onboarding
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
