class Job {
  final String id;
  final String name;
  final DateTime startDate;
  final int estimatedDurationMinutes;
  final String contactId;

  Job({
    required this.id,
    required this.name,
    required this.startDate,
    required this.estimatedDurationMinutes,
    required this.contactId,
  });
}
