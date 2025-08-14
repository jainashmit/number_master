// lib/widgets/custom_button.dart
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final int badge;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.badge,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(badge.toString(), style: const TextStyle(color: Colors.white)),
      child: IconButton(
        icon: Icon(icon, color: Colors.purple, size: 50),
        onPressed: onPressed,
      ),
    );
  }
}