import 'package:flutter/material.dart';
class ButtonWidget2 extends StatelessWidget {
  const ButtonWidget2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
          borderRadius: BorderRadius.circular(10), // Match the button's shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 4), // Changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:(){},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Set to transparent to use the container's color
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Shape matches the container's borderRadius
            ),
            elevation: 0, // Removes the default elevation of ElevatedButton
          ),
          child: const Text(
            "Sign In With Google",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// 2