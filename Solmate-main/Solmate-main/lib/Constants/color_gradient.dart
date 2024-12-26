// background_gradient.dart
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF332943), Color(0xFF1B2236)],
          begin: Alignment.center,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
