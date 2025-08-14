// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _textAnimation;
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);
    _textController.forward();

    _dotsController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _textAnimation,
                child: const Text(
                  'Number Master',
                  style: TextStyle(fontSize: 50, color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.5, end: 1.5).animate(
                      CurvedAnimation(parent: _dotsController, curve: Interval(0.2 * index, 0.2 * index + 0.4)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.star, color: Colors.yellow, size: 20),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}