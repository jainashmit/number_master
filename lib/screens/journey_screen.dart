// lib/screens/journey_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/game_screen.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Journey', style: TextStyle(fontSize: 40, color: Colors.white)),
              const SizedBox(height: 20),
              // Simple path with 3 levels
              Column(
                children: List.generate(3, (index) {
                  final level = index + 1;
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(level: level, stage: 1))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        level == 1 ? Icons.lock_open : Icons.lock,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  );
                }),
              ),
              const Text('Complete 3 daily challenges to unlock the journey.', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}