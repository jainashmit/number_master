// lib/screens/daily_challenges_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/game_screen.dart';

class DailyChallengesScreen extends StatelessWidget {
  const DailyChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = now.month;
    final year = now.year;
    final monthName = _getMonthName(month);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday % 7; // Sunday = 0

    List<TableRow> calendarRows = [
      const TableRow(children: [
        Text('Sun',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Mon',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Tue',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Wed',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Thu',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Fri',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        Text('Sat',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
      ]),
    ];

    List<Text> week = List.generate(7, (_) => const Text(''));
    for (int day = 1; day <= daysInMonth; day++) {
      final weekday = (firstWeekday + day - 1) % 7;
      week[weekday] = Text('$day',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              backgroundColor: day == now.day ? Colors.purple : null));
      if (weekday == 6 || day == daysInMonth) {
        calendarRows.add(TableRow(children: week));
        week = List.generate(7, (_) => const Text(''));
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Daily Challenges',
                style: TextStyle(fontSize: 30, color: Colors.white)),
            Text('$monthName $year',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: Colors.purple[200]!),
              children: calendarRows,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameScreen(level: 1, stage: 1))),
              child: const Text('Play',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
