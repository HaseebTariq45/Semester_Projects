import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneakers_app/models/shoe_model.dart';
import 'dart:math';

import '../utils/app_methods.dart';

class FootSizeDetector extends StatefulWidget {
  @override
  _FootSizeDetectorState createState() => _FootSizeDetectorState();
}

class _FootSizeDetectorState extends State<FootSizeDetector> with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  String detectedSize = '';
  bool showAnimation = false;

  // Replace this with your actual sizes
  List<String> sizes = ['6.0', '7.5', '8.0', '9.5'];

  Future<void> tryShoeSize() async {
    // Open the camera
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Simulate foot detection and randomly assign a size
      Random random = Random();
      int randomIndex = random.nextInt(sizes.length);
      detectedSize = sizes[randomIndex];

      // Trigger the animation
      setState(() {
        showAnimation = true;
      });

      // Show the detected size after a brief delay
      await Future.delayed(Duration(seconds: 2));
      // Here you can add more options or logic to display the size to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foot Size Detector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            if (showAnimation) AnimatedSizeScreen(detectedSize: detectedSize),
          ],
        ),
      ),
    );
  }
}

class AnimatedSizeScreen extends StatelessWidget {
  final String detectedSize;

  AnimatedSizeScreen({required this.detectedSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green, // Green background
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your detected shoe size is:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            detectedSize,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}
