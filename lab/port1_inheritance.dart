abstract class Meter {
final String id;
final double start;
final double end;

const Meter(this.id, this.start, this.end);

double get consumed => end - start;

double cost(double tariff) => consumed * tariff;
}

class GeneratorMeter extends Meter {
final double fuelLitres;

const GeneratorMeter(
super.id,
super.start,
super.end, {
required this.fuelLitres,
});
GeneratorMeter.fromReadings(
  String id,
  List<double> readings, {
  required double fuelLitres,
}) : this(
        id,
        _firstReading(readings),
        readings.last,
        fuelLitres: fuelLitres,
      );

static double _firstReading(List<double> readings) {
  if (readings.isEmpty) {
    throw ArgumentError('Readings cannot be empty');
  }
  return readings.first;
}
double? get kwhPerLitre =>
fuelLitres == 0 ? null : consumed / fuelLitres;
}

void main() {
final g = GeneratorMeter.fromReadings(
  'G-102',
  [15200, 15350, 15640],
  fuelLitres: 140,
);

print(
'${g.consumed} kWh, cost ${g.cost(120)} IQD, '
'efficiency ${g.kwhPerLitre?.toStringAsFixed(2)} kWh/L',
);

}
