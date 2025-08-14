// lib/screens/how_to_play_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/home_screen.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  final PageController _pageController = PageController();

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
        child: PageView(
          controller: _pageController,
          children: [
            _buildStep(
                1,
                'Find pairs of numbers',
                'Find numbers that are either equal or add up to 10, and tap them.',
                [1, 9, 2, 8],
                [true, true, false, false]),
            _buildStep(
                2,
                'Select first number',
                'Tap on the first number to highlight it.',
                [3, 7, 4, 6],
                [true, false, false, false]),
            _buildStep(
                3,
                'Select second number',
                'Tap on the second number to match.',
                [5, 5, 6, 4],
                [true, true, false, false]),
            _buildStep(
                4,
                'Match effect',
                'If valid, they will burst and disappear.',
                [2, 8, 3, 7],
                [false, false, false, false]),
            _buildStep(5, 'Add row', 'If stuck, tap + to add a new row.',
                [1, 2, 3, 4], [false, false, false, false]),
            _buildStep(6, 'Hint', 'Use lightbulb for hints.', [9, 1, 8, 2],
                [true, true, false, false]),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  if (_pageController.page! > 0)
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                },
                child: const Text('Previous',
                    style: TextStyle(color: Colors.white))),
            TextButton(
                onPressed: () {
                  if (_pageController.page! < 5) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                },
                child: Text(
                    _pageController.hasClients && _pageController.page == 5
                        ? 'Continue'
                        : 'Next',
                    style: const TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int step, String title, String description,
      List<int> exampleNumbers, List<bool> highlights) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('How to Play',
              style: TextStyle(fontSize: 30, color: Colors.white)),
          Text(title,
              style: const TextStyle(fontSize: 24, color: Colors.yellow)),
          Text(description, style: const TextStyle(color: Colors.white)),
          Container(
            margin: const EdgeInsets.all(20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(
                  exampleNumbers.length,
                  (i) => Container(
                        color: highlights[i]
                            ? Colors.yellow.withOpacity(0.5)
                            : Colors.purple.withOpacity(0.2),
                        child: Center(
                            child: Text('${exampleNumbers[i]}',
                                style: const TextStyle(color: Colors.white))),
                      )),
            ),
          ),
          Text('Step $step/6', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
