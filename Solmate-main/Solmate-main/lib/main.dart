import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentication/login_page.dart';
import '../controllers/theme_controller.dart'; // Import the ThemeController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBhBlEHCMnkl9Gca_7LdoXdh6o3pQ4RxEg",
      authDomain: "management-ec9de.firebaseapp.com",
      projectId: "management-ec9de",
      storageBucket: "management-ec9de.firebasestorage.app",
      messagingSenderId: "873046477471",
      appId: "1:873046477471:web:cdbfd065e3e2e6fd1630aa",
      measurementId: "G-Y1X2Q4EWN2",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the ThemeController
    final themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          textTheme: ThemeData.light().textTheme.apply(
            fontFamily: 'Quicksand', // Apply the font to the text theme
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: 'Quicksand', // Apply the font to the text theme
          ),
        ),
        themeMode: themeController.themeMode.value, // Bind the themeMode here
        title: 'Sneakers Shop App',
        home: LoginPage(), // Change this as per your flow
      );
    });
  }
}
