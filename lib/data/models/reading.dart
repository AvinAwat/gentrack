enum SyncState {
  pending,
  synced,
  failed,
}

class Reading {
  final String id;
  final String assetId;
  final double value;
  final DateTime timestamp;
  final SyncState syncState;

  const Reading({
    required this.id,
    required this.assetId,
    required this.value,
    required this.timestamp,
    this.syncState = SyncState.pending,
  });

  Reading copyWith({
    String? id,
    String? assetId,
    double? value,
    DateTime? timestamp,
    SyncState? syncState,
  }) {
    return Reading(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      syncState: syncState ?? this.syncState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'value': value,
      'timestamp': timestamp.toIso8601String(),
      'syncState': syncState.name,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Reading &&
            other.id == id &&
            other.assetId == assetId &&
            other.value == value &&
            other.timestamp == timestamp &&
            other.syncState == syncState;
  }

  @override
  int get hashCode =>
      Object.hash(id, assetId, value, timestamp, syncState);
}