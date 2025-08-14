// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/daily_challenges_screen.dart';
import 'package:number_master/screens/journey_screen.dart';
import 'package:number_master/screens/how_to_play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _screens.addAll([
      Center(
        child: ScaleTransition(
          scale: Tween(begin: 0.9, end: 1.1).animate(_animationController),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Number Master',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HowToPlayScreen())),
                child: const Text('How to Play'),
              ),
            ],
          ),
        ),
      ),
      const DailyChallengesScreen(),
      const JourneyScreen(),
    ]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Daily Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Journey'),
        ],
      ),
    );
  }
}
