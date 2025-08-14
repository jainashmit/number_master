// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/daily_challenges_screen.dart';
import 'package:number_master/screens/journey_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: const Center(
          child: Text('Welcome to Number Master', style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Daily Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Journey'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyChallengesScreen()));
          }
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const JourneyScreen()));
          }
        },
      ),
    );
  }
}