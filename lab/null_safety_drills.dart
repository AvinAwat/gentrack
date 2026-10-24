import 'package:gentrack/data/models/asset.dart';
import 'package:gentrack/data/models/reading.dart';


String label(Asset? a) {
  if (a == null) return 'Unknown asset';
  return a.name;
}
double? efficiency(double? kwh, double? litres) {
  if (kwh == null || litres == null || litres == 0) {
    return null;
  }
  return kwh / litres;
}
int fuelBars(int? percent) {
  final value = (percent ?? 0).clamp(0, 100);
  return (value / 20).ceil();
}
String lastSeen(DateTime? t, {DateTime? now}) {
  if (t == null) return 'never';

  final currentTime = now ?? DateTime.now();
  final difference = currentTime.difference(t);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else {
    return '${difference.inHours} h ago';
  }
}
class Tracker {
  Reading? _latest;

  void update(Reading reading) {
    _latest = reading;
  }

  String latestLabel() {
    final reading = _latest;

    if (reading == null) {
      return 'No reading available';
    }

    return 'Latest reading: $reading';
  }
}