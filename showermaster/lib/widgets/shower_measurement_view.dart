import 'package:flutter/material.dart';

class ShowerMeasurementView extends StatelessWidget {
  final Map<String, String> measurements;
  final Function(String) onMeasurementTap;

  const ShowerMeasurementView({
    super.key,
    required this.measurements,
    required this.onMeasurementTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: ShowerOutlinePainter(
          measurements: measurements,
          onMeasurementTap: onMeasurementTap,
        ),
        child: Container(),
      ),
    );
  }
}

class ShowerOutlinePainter extends CustomPainter {
  final Map<String, String> measurements;
  final Function(String) onMeasurementTap;

  ShowerOutlinePainter({
    required this.measurements,
    required this.onMeasurementTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Isometric shower outline dimensions
    const showerWidth = 120.0;
    const showerDepth = 80.0;
    const showerHeight = 180.0;
    
    // Isometric projection ratios
    const isoX = 0.866; // cos(30°)
    const isoY = 0.5;   // sin(30°)

    // Calculate shower outline points
    final frontLeft = Offset(
      centerX - (showerWidth * isoX / 2),
      centerY + (showerWidth * isoY / 2) + showerHeight / 2,
    );
    final frontRight = Offset(
      centerX + (showerWidth * isoX / 2),
      centerY - (showerWidth * isoY / 2) + showerHeight / 2,
    );
    final backLeft = Offset(
      centerX - (showerWidth * isoX / 2) - (showerDepth * isoX / 2),
      centerY + (showerWidth * isoY / 2) - (showerDepth * isoY / 2) + showerHeight / 2,
    );
    final backRight = Offset(
      centerX + (showerWidth * isoX / 2) - (showerDepth * isoX / 2),
      centerY - (showerWidth * isoY / 2) - (showerDepth * isoY / 2) + showerHeight / 2,
    );

    // Top face points
    final topFrontLeft = Offset(frontLeft.dx, frontLeft.dy - showerHeight);
    final topFrontRight = Offset(frontRight.dx, frontRight.dy - showerHeight);
    final topBackLeft = Offset(backLeft.dx, backLeft.dy - showerHeight);
    final topBackRight = Offset(backRight.dx, backRight.dy - showerHeight);

    // Draw main shower outline
    final path = Path();
    
    // Bottom face
    path.moveTo(frontLeft.dx, frontLeft.dy);
    path.lineTo(frontRight.dx, frontRight.dy);
    path.lineTo(backRight.dx, backRight.dy);
    path.lineTo(backLeft.dx, backLeft.dy);
    path.close();

    // Top face
    path.moveTo(topFrontLeft.dx, topFrontLeft.dy);
    path.lineTo(topFrontRight.dx, topFrontRight.dy);
    path.lineTo(topBackRight.dx, topBackRight.dy);
    path.lineTo(topBackLeft.dx, topBackLeft.dy);
    path.close();

    // Vertical edges
    path.moveTo(frontLeft.dx, frontLeft.dy);
    path.lineTo(topFrontLeft.dx, topFrontLeft.dy);
    
    path.moveTo(frontRight.dx, frontRight.dy);
    path.lineTo(topFrontRight.dx, topFrontRight.dy);
    
    path.moveTo(backLeft.dx, backLeft.dy);
    path.lineTo(topBackLeft.dx, topBackLeft.dy);
    
    path.moveTo(backRight.dx, backRight.dy);
    path.lineTo(topBackRight.dx, topBackRight.dy);

    canvas.drawPath(path, paint);

    // Draw door opening
    final doorPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final doorWidth = 30.0;
    final doorStart = Offset(
      frontLeft.dx + 20,
      frontLeft.dy,
    );
    final doorEnd = Offset(
      doorStart.dx + doorWidth,
      doorStart.dy,
    );
    final doorTopStart = Offset(doorStart.dx, doorStart.dy - showerHeight);
    final doorTopEnd = Offset(doorEnd.dx, doorEnd.dy - showerHeight);

    canvas.drawLine(doorStart, doorTopStart, doorPaint);
    canvas.drawLine(doorEnd, doorTopEnd, doorPaint);
    canvas.drawLine(doorTopStart, doorTopEnd, doorPaint);

    // Draw measurements
    _drawMeasurement(
      canvas,
      '80"',
      frontLeft,
      Offset(frontLeft.dx, frontLeft.dy - showerHeight),
      MeasurementPosition.left,
      Colors.blue,
    );

    _drawMeasurement(
      canvas,
      '59-7/8"',
      frontRight,
      backRight,
      MeasurementPosition.right,
      Colors.black,
    );

    _drawMeasurement(
      canvas,
      '19"',
      Offset(frontRight.dx, frontRight.dy - 40),
      Offset(frontRight.dx, frontRight.dy - 80),
      MeasurementPosition.right,
      Colors.blue,
    );

    _drawMeasurement(
      canvas,
      '20"',
      Offset(frontRight.dx, frontRight.dy - 80),
      Offset(frontRight.dx, frontRight.dy - 120),
      MeasurementPosition.right,
      Colors.red,
    );

    _drawMeasurement(
      canvas,
      '28"',
      frontLeft,
      frontRight,
      MeasurementPosition.bottom,
      Colors.green,
    );

    _drawMeasurement(
      canvas,
      '18"',
      Offset(frontRight.dx - 30, frontRight.dy),
      frontRight,
      MeasurementPosition.bottom,
      Colors.orange,
    );
  }

  void _drawMeasurement(
    Canvas canvas,
    String text,
    Offset start,
    Offset end,
    MeasurementPosition position,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Draw measurement line
    canvas.drawLine(start, end, paint);

    // Draw end markers
    _drawMeasurementMarker(canvas, start, paint);
    _drawMeasurementMarker(canvas, end, paint);

    // Position text based on measurement position
    Offset textOffset;
    switch (position) {
      case MeasurementPosition.left:
        textOffset = Offset(
          start.dx - textPainter.width - 10,
          (start.dy + end.dy) / 2 - textPainter.height / 2,
        );
        break;
      case MeasurementPosition.right:
        textOffset = Offset(
          start.dx + 10,
          (start.dy + end.dy) / 2 - textPainter.height / 2,
        );
        break;
      case MeasurementPosition.bottom:
        textOffset = Offset(
          (start.dx + end.dx) / 2 - textPainter.width / 2,
          start.dy + 20,
        );
        break;
    }

    textPainter.paint(canvas, textOffset);
  }

  void _drawMeasurementMarker(Canvas canvas, Offset point, Paint paint) {
    canvas.drawCircle(point, 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum MeasurementPosition {
  left,
  right,
  bottom,
}