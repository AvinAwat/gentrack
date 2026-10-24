import 'package:flutter_test/flutter_test.dart';
import 'package:gentrack/data/models/asset.dart';
import 'package:gentrack/data/models/reading.dart';
import 'package:gentrack/data/fake_reading_repo.dart';
import 'package:gentrack/data/models/sync_state.dart' as sync_model;


void main() {
  group('Asset tests', () {
    test('accepts a valid asset ID', () {
      expect(Asset.isValidId('M-001'), isTrue);
      expect(Asset.isValidId('G-123'), isTrue);
    });

    test('rejects an invalid asset ID', () {
      expect(Asset.isValidId('m-001'), isFalse);
      expect(Asset.isValidId('M-01'), isFalse);
      expect(Asset.isValidId('M-0001'), isFalse);
    });

    test('converts an asset to JSON', () {
      const asset = Asset(
        id: 'M-001',
        name: 'Main Meter',
        type: AssetType.meter,
      );

      expect(asset.toJson(), {
        'id': 'M-001',
        'name': 'Main Meter',
        'type': 'meter',
      });
    });

    test('compares assets by value', () {
      const first = Asset(
        id: 'M-001',
        name: 'Main Meter',
        type: AssetType.meter,
      );

      const second = Asset(
        id: 'M-001',
        name: 'Main Meter',
        type: AssetType.meter,
      );

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
    });
  });

  group('Reading tests', () {
    final timestamp = DateTime.utc(2026, 1, 1);

    test('copyWith changes sync state and preserves other fields', () {
      final reading = Reading(
        id: 'R-001',
        assetId: 'M-001',
        value: 12.5,
        timestamp: timestamp,
      );

      final updated = reading.copyWith(
        syncState: SyncState.synced,
      );

      expect(updated.syncState, SyncState.synced);
      expect(updated.id, reading.id);
      expect(updated.assetId, reading.assetId);
      expect(updated.value, reading.value);
      expect(updated.timestamp, reading.timestamp);
    });

    test('converts a reading to JSON', () {
      final reading = Reading(
        id: 'R-001',
        assetId: 'M-001',
        value: 12.5,
        timestamp: timestamp,
        syncState: SyncState.synced,
      );

      expect(reading.toJson(), {
        'id': 'R-001',
        'assetId': 'M-001',
        'value': 12.5,
        'timestamp': timestamp.toIso8601String(),
        'syncState': 'synced',
      });
    });

    test('compares readings by value', () {
      final first = Reading(
        id: 'R-001',
        assetId: 'M-001',
        value: 12.5,
        timestamp: timestamp,
      );

      final second = Reading(
        id: 'R-001',
        assetId: 'M-001',
        value: 12.5,
        timestamp: timestamp,
      );

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
    });
  });
  

 test('broadcasts reading lists to listeners', () async {
  final repository = FakeReadingRepository();
  final timestamp = DateTime.utc(2026, 1, 1);

  final receivedFuture = repository.watch().first;

  await repository.add(
    Reading(
      id: 'R-002',
      assetId: 'M-001',
      value: 20.0,
      timestamp: timestamp,
    ),
  );

  expect(await receivedFuture, hasLength(1));

  await repository.dispose();
});
  test('rejects readings after disposal', () async {
final repository = FakeReadingRepository();

await repository.dispose();

expect(
() => repository.add(
Reading(
id: 'R-003',
assetId: 'M-001',
value: 30.0,
timestamp: DateTime.now(),
),
),
throwsStateError,
);
});
group('SyncState model tests', () {
    test('compares states by value and hashCode', () {
      const first = sync_model.SyncState(
        status: sync_model.SyncStatus.success,
        message: 'Synced',
      );

      const second = sync_model.SyncState(
        status: sync_model.SyncStatus.success,
        message: 'Synced',
      );

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));

      const different = sync_model.SyncState(
        status: sync_model.SyncStatus.failed,
        message: 'Synced',
      );

      expect(first, isNot(equals(different)));
    });
  });

}

