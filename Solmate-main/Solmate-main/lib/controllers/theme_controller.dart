import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  // Rx to track the theme mode (light or dark)
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // Method to toggle the theme
  void toggleTheme() {
    // Toggle between light and dark mode
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }
}
