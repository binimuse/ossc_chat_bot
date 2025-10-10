import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MainPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
