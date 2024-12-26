import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app/data/local/my_shared_pref.dart'; // If you have a custom SharedPref class
import 'config/theme/my_theme.dart'; // If you have a custom theme class
import 'LoginScreen.dart'; // Import Login Screen
import 'SignupScreen.dart'; // Import Sign Up Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences (optional)
  await MySharedPref.init();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDYlPApIdKLM_p86upi5eRqIHkoTnMsMXk",
        authDomain: "ecommerce-54f96.firebaseapp.com",
        projectId: "ecommerce-54f96",
        storageBucket: "ecommerce-54f96.firebasestorage.app",
        messagingSenderId: "239813268186",
        appId: "1:239813268186:web:a92f7fba4bec3d7b5d8be3"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "E-commerce App",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            bool themeIsLight = MySharedPref
                .getThemeIsLight(); // Get theme from SharedPreferences
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight), // Set theme
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1.0)),
                child: widget!,
              ),
            );
          },
          initialRoute:
              '/login', // Set the first screen when the app is launched
          getPages: [
            GetPage(
                name: '/login',
                page: () => const LoginScreen()), // Login page route
            GetPage(
                name: '/signup',
                page: () => const SignupScreen()), // Signup page route
          ],
        );
      },
    );
  }
}
