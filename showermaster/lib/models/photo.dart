class Photo {
  final String id;
  final String entityType; // Job, Visit, Shower
  final String entityId;
  final DateTime timestamp;
  final String localPath;
  final String? caption;

  Photo({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.timestamp,
    required this.localPath,
    this.caption,
  });
}
