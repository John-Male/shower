class Measurement {
  final String type;
  final String value;
  final String unit;
  final bool isLevel;

  const Measurement({
    required this.type,
    required this.value,
    this.unit = '"',
    this.isLevel = false,
  });

  Measurement copyWith({
    String? type,
    String? value,
    String? unit,
    bool? isLevel,
  }) {
    return Measurement(
      type: type ?? this.type,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      isLevel: isLevel ?? this.isLevel,
    );
  }
}

enum MeasurementType {
  width,
  height,
  depth,
}