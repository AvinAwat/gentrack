import 'dart:async';

import 'models/reading.dart';

class FakeReadingRepository {
  final List<Reading> _items = [];

  final StreamController<List<Reading>> _controller =
      StreamController<List<Reading>>.broadcast();

  bool _disposed = false;

  Stream<List<Reading>> watch() => _controller.stream;

  Future<void> add(Reading reading) async {
    if (_disposed) {
      throw StateError('Repository has been disposed.');
    }

    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    _items.add(reading);
    _controller.add(List<Reading>.unmodifiable(_items));
  }

  Future<void> dispose() async {
    if (_disposed) return;

    _disposed = true;
    await _controller.close();
  }
}