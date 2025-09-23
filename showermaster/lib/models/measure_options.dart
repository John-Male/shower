enum MeasureMethod { centerlineGlass, exteriorGlass, centerlineMetal, exteriorMetal }
enum TransformType { none, fixed, operable, headGap }

class MeasureOptions {
  final String showerId;
  final MeasureMethod method;
  final double? doorGlassWidthMm;
  final TransformType transform;
  final String doorActionId;
  final double? topHingeOffsetMm;
  final double? bottomHingeOffsetMm;

  MeasureOptions({
    required this.showerId,
    required this.method,
    this.doorGlassWidthMm,
    required this.transform,
    required this.doorActionId,
    this.topHingeOffsetMm,
    this.bottomHingeOffsetMm,
  });
}
