enum HandleSide { left, right }

class Panel {
  final int index;
  final bool isDoor;
  final double? widthMm;
  final double? heightMm;
  final HandleSide? handleSide;
  final bool hasBenchNotch;
  final bool isNotchReversed;
  final double? notchVerticalOffsetMm;
  final double? notchVerticalHeightMm;
  final double? notchHorizontalOffsetMm;
  final double? notchHorizontalDepthMm;

  Panel({
    required this.index,
    required this.isDoor,
    this.widthMm,
    this.heightMm,
    this.handleSide,
    this.hasBenchNotch = false,
    this.isNotchReversed = false,
    this.notchVerticalOffsetMm,
    this.notchVerticalHeightMm,
    this.notchHorizontalOffsetMm,
    this.notchHorizontalDepthMm,
  });

  Panel copyWith({
    int? index,
    bool? isDoor,
    double? widthMm,
    double? heightMm,
    HandleSide? handleSide,
    bool? hasBenchNotch,
    bool? isNotchReversed,
    double? notchVerticalOffsetMm,
    double? notchVerticalHeightMm,
    double? notchHorizontalOffsetMm,
    double? notchHorizontalDepthMm,
  }) {
    return Panel(
      index: index ?? this.index,
      isDoor: isDoor ?? this.isDoor,
      widthMm: widthMm ?? this.widthMm,
      heightMm: heightMm ?? this.heightMm,
      handleSide: handleSide ?? this.handleSide,
      hasBenchNotch: hasBenchNotch ?? this.hasBenchNotch,
      isNotchReversed: isNotchReversed ?? this.isNotchReversed,
      notchVerticalOffsetMm: notchVerticalOffsetMm ?? this.notchVerticalOffsetMm,
      notchVerticalHeightMm: notchVerticalHeightMm ?? this.notchVerticalHeightMm,
      notchHorizontalOffsetMm: notchHorizontalOffsetMm ?? this.notchHorizontalOffsetMm,
      notchHorizontalDepthMm: notchHorizontalDepthMm ?? this.notchHorizontalDepthMm,
    );
  }
}
