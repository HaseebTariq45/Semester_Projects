import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYlPApIdKLM_p86upi5eRqIHkoTnMsMXk",
      authDomain: "ecommerce-54f96.firebaseapp.com",
      projectId: "ecommerce-54f96",
      storageBucket: "ecommerce-54f96.firebasestorage.app",
      messagingSenderId: "239813268186",
      appId: "1:239813268186:web:a92f7fba4bec3d7b5d8be3",
      measurementId: "G-Y1X2Q4EWN2",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(), // Default page set to LoginPage
    );
  }
}
