import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int _readings = 0;
  int _faults = 0;

  void _logReading({bool fault = false}) {
    setState(() {
      _readings++;
      if (fault) {
        _faults++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('GenTrack — Today (Hot Reload)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.electric_meter,
              size: 96,
            ),
            const SizedBox(height: 16),
            Text('$_readings readings'),
            const SizedBox(height: 8),
            Text('$_faults faults reported'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _logReading,
        icon: const Icon(Icons.add),
        label: const Text('Log reading'),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () => _logReading(fault: true),
          child: const Text('Log fault'),
        ),
      ],
    );
  }
}