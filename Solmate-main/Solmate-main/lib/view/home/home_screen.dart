import 'package:flutter/material.dart';
import '../../controllers/theme_controller.dart';  // Import the theme controller
import 'package:get/get.dart';
import '../../utils/constants.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the ThemeController
    final themeController = Get.find<ThemeController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(
                themeController.themeMode.value == ThemeMode.light
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ],
        ),
        body: const Body(),
      ),
    );
  }
}
