// lib/widgets/number_tile.dart
import 'package:flutter/material.dart';

class NumberTile extends StatelessWidget {
  final int number;
  final bool isSelected;
  final bool isHinted;
  final VoidCallback onTap;

  const NumberTile({
    super.key,
    required this.number,
    required this.isSelected,
    required this.isHinted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.accents[number % Colors.accents.length];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple[200]!),
          color: isSelected || isHinted ? const Color.fromARGB(76, 255, 255, 255): null,
        ),
        child: Center(
          child: Text('$number', style: TextStyle(fontSize: 30, color: color)),
        ),
      ),
    );
  }
}
