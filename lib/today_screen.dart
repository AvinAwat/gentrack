import 'package:flutter/material.dart';
import 'dart:isolate';

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
  void _simulateBlockingWorkOnUI() {
  final stopwatch = Stopwatch()..start();
  var value = 0;

  while (stopwatch.elapsedMilliseconds < 3000) {
    value++;
  }

  stopwatch.stop();

  debugPrint(
    'UI blocking work took ${stopwatch.elapsedMilliseconds} ms; value=$value',
  );
} 
Future<void> _simulateBlockingWork() async {
  final stopwatch = Stopwatch()..start();

  final value = await Isolate.run(() {
    var result = 0;

    while (result < 100000000) {
      result++;
    }

    return result;
  });

  stopwatch.stop();

  debugPrint(
    'Isolate work took ${stopwatch.elapsedMilliseconds} ms; value=$value',
  );
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _simulateBlockingWorkOnUI,
              child: const Text('Test UI Blocking'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _simulateBlockingWork,
              child: const Text('Test Isolate.run'),
            ),
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