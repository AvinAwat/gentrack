class Buffer<T extends num> {
  final List<T?> _data;

  Buffer(int size) : _data = List<T?>.filled(size, null);

  int get length => _data.length;

  void set(int index, T value) {
    _data[index] = value;
  }

  T? get(int index) => _data[index];

  Iterable<T> get values sync* {
    for (final value in _data) {
      if (value != null) yield value;
    }
  }

  int positiveModulo(int value, int divisor) {
    if (divisor <= 0) {
      throw ArgumentError('Divisor must be positive');
    }
    return ((value % divisor) + divisor) % divisor;
  }
}

void main() {
  final buffer = Buffer<int>(3);

  buffer.set(0, 10);
  buffer.set(1, 20);
  buffer.set(2, 30);

  print('Values: ${buffer.values.toList()}');
  print('Positive modulo: ${buffer.positiveModulo(-1, 3)}');
}