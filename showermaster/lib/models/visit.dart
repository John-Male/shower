enum VisitStatus { planned, done, missed }

class Visit {
  final String id;
  final String jobId;
  final DateTime scheduledAt;
  final int durationMinutes;
  final VisitStatus status;

  Visit({
    required this.id,
    required this.jobId,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.status,
  });
}
