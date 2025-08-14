// lib/screens/how_to_play_screen.dart
import 'package:flutter/material.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How to Play')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Find pairs of numbers that are either equal or add up to 10, and tap them.'),
            Text('Steps: 1/6'), // Add tabs or pages for multi-step
            // Add more steps as images or text
          ],
        ),
      ),
    );
  }
}