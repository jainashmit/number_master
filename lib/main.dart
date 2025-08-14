// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_master/app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}