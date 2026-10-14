import 'package:flutter_test/flutter_test.dart';
import 'package:gentrack/main.dart';

void main() {
  testWidgets(
    'logging a reading and a fault updates counters',
    (tester) async {
      await tester.pumpWidget(const GenTrackApp());

      expect(find.text('0 readings'), findsOneWidget);

      await tester.tap(find.text('Log reading'));
      await tester.tap(find.text('Log fault'));
      await tester.pump();

      expect(find.text('2 readings'), findsOneWidget);
      expect(find.text('1 faults reported'), findsOneWidget);
    },
  );
}