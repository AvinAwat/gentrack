import 'package:flutter/material.dart';
import 'today_screen.dart';

void main() {
  runApp(const GenTrackApp());
}

class GenTrackApp extends StatelessWidget {
  const GenTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7490),
        ),
      ),
      home: const TodayScreen(),
    );
  }
}