enum ShowerStyle { inline, square, quadrant }
enum DoorType { left, right, double }

class Shower {
  final String id;
  final String jobId;
  final String? visitId;
  final String name;
  final ShowerStyle style;
  final DoorType doorType;
  final String templateId;
  final int panelCount;

  Shower({
    required this.id,
    required this.jobId,
    this.visitId,
    required this.name,
    required this.style,
    required this.doorType,
    required this.templateId,
    required this.panelCount,
  });
}
