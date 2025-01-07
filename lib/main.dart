import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ScrapShareApp());
}

class ScrapShareApp extends StatelessWidget {
  const ScrapShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrap Share',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Pastel background
      ),
      home: const HomeScreen(),
    );
  }
}
