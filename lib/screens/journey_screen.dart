// lib/screens/journey_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/game_screen.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Journey',
              style: TextStyle(fontSize: 40, color: Colors.white)),
          const SizedBox(height: 20),
          Column(
            children: List.generate(3, (index) {
              final level = index + 1;
              return ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.1).animate(_controller),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(level: level, stage: 1))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      level == 1 ? Icons.lock_open : Icons.lock,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              );
            }),
          ),
          const Text('Complete 3 daily challenges to unlock the journey.',
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
