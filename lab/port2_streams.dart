import 'dart:async';
import 'dart:math';

final _rnd = Random(1);

double readSensor() => 220 + _rnd.nextDouble() * 10;

Future<void> producer(StreamController<double> out) async {
for (var i = 0; i < 5; i++) {
out.add(readSensor());
await Future.delayed(const Duration(milliseconds: 200));
}
await out.close();
}

Future<void> consumer(Stream<double> input) async {
await for (final v in input) {
print('got ${v.toStringAsFixed(1)} V');
}
print('consumer finished');
}

Future<void> main() async {
final c = StreamController<double>();

await Future.wait([
producer(c),
consumer(c.stream),
]);
}

Stream<double> sensor() =>
Stream.periodic(
const Duration(milliseconds: 200),
(_) => readSensor(),
).take(5);