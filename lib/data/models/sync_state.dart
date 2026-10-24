enum SyncStatus {
  idle,
  syncing,
  success,
  failed,
}

class SyncState {
  final SyncStatus status;
  final String? message;
  final DateTime? lastSyncedAt;

  const SyncState({
    this.status = SyncStatus.idle,
    this.message,
    this.lastSyncedAt,
  });

  bool get isSyncing => status == SyncStatus.syncing;

  bool get hasError => status == SyncStatus.failed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncState &&
          other.status == status &&
          other.message == message &&
          other.lastSyncedAt == lastSyncedAt;

  @override
  int get hashCode => Object.hash(status, message, lastSyncedAt);
}