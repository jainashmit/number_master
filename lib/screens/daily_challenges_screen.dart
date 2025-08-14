// lib/screens/daily_challenges_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/game_screen.dart';

class DailyChallengesScreen extends StatelessWidget {
  const DailyChallengesScreen({super.key});

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
              const Text('Daily Challenges', style: TextStyle(fontSize: 30, color: Colors.white)),
              const Text('August 2025', style: TextStyle(color: Colors.white)),
              Table(
                children: [
                  const TableRow(children: [
                    Text('Sun', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Mon', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Tue', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Wed', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Thu', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Fri', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('Sat', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('1', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('2', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('3', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('4', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('5', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('6', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('7', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('8', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('9', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('10', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('11', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('12', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('13', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    Text('14', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, backgroundColor: Colors.purple)),
                    const Text('15', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('16', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('17', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('18', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('19', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('20', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('21', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('22', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('23', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('24', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('25', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('26', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('27', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('28', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('29', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('30', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                  TableRow(children: [
                    const Text('31', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                    const Text('', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ]),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(level: 1, stage: 1))), // Daily level
                child: const Text('Play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}