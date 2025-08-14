// lib/widgets/number_tile.dart
import 'package:flutter/material.dart';

class NumberTile extends StatelessWidget {
  final int number;
  final bool isFaded;
  final bool isSelected;
  final bool isHinted;
  final VoidCallback onTap;

  const NumberTile({
    super.key,
    required this.number,
    required this.isFaded,
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
          color: isSelected || isHinted ? Colors.white.withOpacity(0.3) : null,
        ),
        child: Center(
          child: Opacity(
            opacity: isFaded ? 0.3 : 1.0,
            child: Text('$number', style: TextStyle(fontSize: 30, color: color)),
          ),
        ),
      ),
    );
  }
}