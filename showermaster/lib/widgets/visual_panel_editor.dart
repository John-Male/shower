import 'package:flutter/material.dart';
import '../models/panel.dart' as PanelModel;
import '../models/shower.dart';

class VisualPanelEditor extends StatefulWidget {
  final List<PanelModel.Panel> panels;
  final ShowerStyle showerStyle;
  final DoorType doorType;
  final Function(int, PanelModel.Panel) onPanelUpdated;

  const VisualPanelEditor({
    super.key,
    required this.panels,
    required this.showerStyle,
    required this.doorType,
    required this.onPanelUpdated,
  });

  @override
  State<VisualPanelEditor> createState() => _VisualPanelEditorState();
}

class _VisualPanelEditorState extends State<VisualPanelEditor> {
  int? selectedPanelIndex;
  String? selectedMeasurement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visual Panel Editor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTapDown: _handleTapDown,
            child: CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: ShowerDiagramPainter(
                panels: widget.panels,
                showerStyle: widget.showerStyle,
                doorType: widget.doorType,
                selectedPanelIndex: selectedPanelIndex,
                selectedMeasurement: selectedMeasurement,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (selectedPanelIndex != null) _buildPanelControls(),
      ],
    );
  }

  void _handleTapDown(TapDownDetails details) {
    final Offset localPosition = details.localPosition;
    
    if (widget.showerStyle == ShowerStyle.square) {
      _handleSquareShowerTap(localPosition);
    } else {
      _handleInlineShowerTap(localPosition);
    }
  }

  void _handleInlineShowerTap(Offset localPosition) {
    // Calculate panel positions for inline shower
    const double diagramWidth = 400 - 100;
    const double diagramHeight = 400 - 100;
    const double panelHeight = diagramHeight * 0.8; // Updated height
    final double panelWidth = (diagramWidth / widget.panels.length) * 0.6; // Updated width
    const double startX = 50;
    const double startY = 50;
    
    // Check which panel was tapped
    for (int i = 0; i < widget.panels.length; i++) {
      final double x = startX + (i * (panelWidth + 10)); // Updated spacing
      final double y = startY;
      final Rect panelRect = Rect.fromLTWH(x, y, panelWidth, panelHeight);
      
      if (panelRect.contains(localPosition)) {
        _onPanelTap(i);
        return;
      }
      
      // Check measurement lines
      final double lineOffset = 20;
      final Rect widthLineRect = Rect.fromLTWH(
        x, 
        y + panelHeight + lineOffset - 5, 
        panelWidth, 
        20
      );
      
      if (widthLineRect.contains(localPosition)) {
        _onMeasurementLineTap(i, 'width');
        return;
      }
      
      final Rect heightLineRect = Rect.fromLTWH(
        x + panelWidth + lineOffset - 10, 
        y, 
        20, 
        panelHeight
      );
      
      if (heightLineRect.contains(localPosition)) {
        _onMeasurementLineTap(i, 'height');
        return;
      }
    }
  }

  void _handleSquareShowerTap(Offset localPosition) {
    // Calculate panel positions for square shower (90-degree layout)
    const double centerX = 400 / 2; // Approximate center
    const double centerY = 400 / 2;
    const double panelLength = 120;
    const double panelWidth = 20;

    final List<Rect> panelRects = [];
    
    if (widget.panels.length >= 3) {
      // Back wall (horizontal)
      panelRects.add(Rect.fromLTWH(
        centerX - panelLength / 2, 
        centerY - panelLength / 2 - panelWidth,
        panelLength, 
        panelWidth
      ));

      // Left wall (vertical)  
      panelRects.add(Rect.fromLTWH(
        centerX - panelLength / 2 - panelWidth,
        centerY - panelLength / 2,
        panelWidth,
        panelLength
      ));

      // Right wall (vertical)
      panelRects.add(Rect.fromLTWH(
        centerX + panelLength / 2,
        centerY - panelLength / 2,
        panelWidth,
        panelLength
      ));
    }

    for (int i = 0; i < widget.panels.length && i < panelRects.length; i++) {
      final rect = panelRects[i];
      
      if (rect.contains(localPosition)) {
        _onPanelTap(i);
        return;
      }
    }
  }

  void _onPanelTap(int panelIndex) {
    setState(() {
      selectedPanelIndex = panelIndex;
      selectedMeasurement = null;
    });
  }

  void _onMeasurementLineTap(int panelIndex, String measurement) {
    setState(() {
      selectedPanelIndex = panelIndex;
      selectedMeasurement = measurement;
    });
    _showMeasurementDialog(panelIndex, measurement);
  }

  void _showMeasurementDialog(int panelIndex, String measurement) {
    final panel = widget.panels[panelIndex];
    double? currentValue;
    
    switch (measurement) {
      case 'width':
        currentValue = panel.widthMm;
        break;
      case 'height':
        currentValue = panel.heightMm;
        break;
      case 'notchWidth':
        currentValue = panel.notchHorizontalDepthMm;
        break;
      case 'notchHeight':
        currentValue = panel.notchVerticalHeightMm;
        break;
    }

    final controller = TextEditingController(
      text: currentValue?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter ${measurement.toUpperCase()} (mm)'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: '$measurement in mm',
            suffixText: 'mm',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null) {
                _updatePanelMeasurement(panelIndex, measurement, value);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _updatePanelMeasurement(int panelIndex, String measurement, double value) {
    final panel = widget.panels[panelIndex];
    PanelModel.Panel updatedPanel;

    switch (measurement) {
      case 'width':
        updatedPanel = panel.copyWith(widthMm: value);
        break;
      case 'height':
        updatedPanel = panel.copyWith(heightMm: value);
        break;
      case 'notchWidth':
        updatedPanel = panel.copyWith(notchHorizontalDepthMm: value);
        break;
      case 'notchHeight':
        updatedPanel = panel.copyWith(notchVerticalHeightMm: value);
        break;
      default:
        return;
    }

    widget.onPanelUpdated(panelIndex, updatedPanel);
  }

  Widget _buildPanelControls() {
    final panel = widget.panels[selectedPanelIndex!];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panel ${selectedPanelIndex! + 1} ${panel.isDoor ? '(Door)' : ''}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (panel.isDoor) ...[
              const Text('Handle Position:'),
              Row(
                children: [
                  Radio<PanelModel.HandleSide?>(
                    value: PanelModel.HandleSide.left,
                    groupValue: panel.handleSide ?? PanelModel.HandleSide.right,
                    onChanged: (value) => _updatePanel(panel.copyWith(handleSide: value)),
                  ),
                  const Text('Left'),
                  Radio<PanelModel.HandleSide?>(
                    value: PanelModel.HandleSide.right,
                    groupValue: panel.handleSide ?? PanelModel.HandleSide.right,
                    onChanged: (value) => _updatePanel(panel.copyWith(handleSide: value)),
                  ),
                  const Text('Right'),
                ],
              ),
              const SizedBox(height: 8),
            ],
            CheckboxListTile(
              title: const Text('Has Bench Notch'),
              value: panel.hasBenchNotch,
              onChanged: (value) => _updatePanel(panel.copyWith(hasBenchNotch: value)),
            ),
            if (panel.hasBenchNotch) ...[
              CheckboxListTile(
                title: const Text('Reverse Notch'),
                value: panel.isNotchReversed,
                onChanged: (value) => _updatePanel(panel.copyWith(isNotchReversed: value)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _updatePanel(PanelModel.Panel updatedPanel) {
    widget.onPanelUpdated(selectedPanelIndex!, updatedPanel);
  }
}

class ShowerDiagramPainter extends CustomPainter {
  final List<PanelModel.Panel> panels;
  final ShowerStyle showerStyle;
  final DoorType doorType;
  final int? selectedPanelIndex;
  final String? selectedMeasurement;

  ShowerDiagramPainter({
    required this.panels,
    required this.showerStyle,
    required this.doorType,
    this.selectedPanelIndex,
    this.selectedMeasurement,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = Colors.blue.shade50
      ..style = PaintingStyle.fill;

    final selectedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final doorPaint = Paint()
      ..color = Colors.brown.shade300
      ..style = PaintingStyle.fill;

    final measurementPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const double startX = 50;
    const double startY = 50;

    // Adjust panel dimensions based on shower style
    if (showerStyle == ShowerStyle.square) {
      _paintSquareShower(canvas, size);
    } else {
      _paintInlineShower(canvas, size);
    }
  }

  void _paintInlineShower(Canvas canvas, Size size) {
    final double diagramWidth = size.width - 100;
    final double diagramHeight = size.height - 100;
    
    // Make panels taller and narrower - more realistic proportions
    final double panelHeight = diagramHeight * 0.8; // Increased from 0.6
    final double panelWidth = (diagramWidth / panels.length) * 0.6; // Reduced width

    const double startX = 50;
    const double startY = 50;

    final paint = Paint()
      ..color = Colors.blue.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = Colors.blue.shade50
      ..style = PaintingStyle.fill;

    final selectedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (int i = 0; i < panels.length; i++) {
      final panel = panels[i];
      final double x = startX + (i * (panelWidth + 10)); // Add spacing between panels
      final double y = startY;

      final rect = Rect.fromLTWH(x, y, panelWidth, panelHeight);
      
      canvas.drawRect(rect, fillPaint);
      canvas.drawRect(
        rect, 
        selectedPanelIndex == i ? selectedPaint : paint,
      );

      if (panel.isDoor) {
        _drawDoorHandle(canvas, rect, panel.handleSide ?? PanelModel.HandleSide.right);
      }

      if (panel.hasBenchNotch) {
        _drawBenchNotchWithLines(canvas, rect, panel);
      }

      _drawMeasurementLines(canvas, rect, i, panel);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + panelWidth / 2 - textPainter.width / 2, y + panelHeight / 2),
      );
    }
  }

  void _paintSquareShower(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = Colors.blue.shade50
      ..style = PaintingStyle.fill;

    final selectedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double panelLength = 120; // Length of each panel
    final double panelWidth = 20;   // Width of each panel (thickness)

    // Calculate positions for square arrangement (90-degree angles)
    final List<Rect> panelRects = [];
    final List<double> rotations = [];

    if (panels.length >= 3) {
      // Back wall (horizontal)
      panelRects.add(Rect.fromLTWH(
        centerX - panelLength / 2, 
        centerY - panelLength / 2 - panelWidth,
        panelLength, 
        panelWidth
      ));
      rotations.add(0);

      // Left wall (vertical)  
      panelRects.add(Rect.fromLTWH(
        centerX - panelLength / 2 - panelWidth,
        centerY - panelLength / 2,
        panelWidth,
        panelLength
      ));
      rotations.add(1.5708); // 90 degrees

      // Right wall (vertical)
      panelRects.add(Rect.fromLTWH(
        centerX + panelLength / 2,
        centerY - panelLength / 2,
        panelWidth,
        panelLength
      ));
      rotations.add(1.5708); // 90 degrees
    }

    for (int i = 0; i < panels.length && i < panelRects.length; i++) {
      final panel = panels[i];
      final rect = panelRects[i];
      
      canvas.save();
      
      canvas.drawRect(rect, fillPaint);
      canvas.drawRect(
        rect, 
        selectedPanelIndex == i ? selectedPaint : paint,
      );

      if (panel.isDoor) {
        _drawDoorHandle(canvas, rect, panel.handleSide ?? PanelModel.HandleSide.right);
      }

      if (panel.hasBenchNotch) {
        _drawBenchNotchWithLines(canvas, rect, panel);
      }

      // Draw panel number
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(rect.center.dx - textPainter.width / 2, rect.center.dy - textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  void _drawDoorHandle(Canvas canvas, Rect panelRect, PanelModel.HandleSide handleSide) {
    final handlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final double handleWidth = 8;
    final double handleHeight = 40;
    final double handleY = panelRect.center.dy - handleHeight / 2;

    double handleX;
    if (handleSide == PanelModel.HandleSide.left) {
      handleX = panelRect.left + 10;
    } else {
      handleX = panelRect.right - 10 - handleWidth;
    }

    canvas.drawRect(
      Rect.fromLTWH(handleX, handleY, handleWidth, handleHeight),
      handlePaint,
    );
  }

  void _drawBenchNotch(Canvas canvas, Rect panelRect, PanelModel.Panel panel) {
    final notchPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final notchStrokePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final double notchWidth = 60;
    final double notchHeight = 40;
    final double notchY = panelRect.bottom - notchHeight - 20;

    double notchX;
    if (panel.isNotchReversed) {
      notchX = panelRect.right - notchWidth - 10;
    } else {
      notchX = panelRect.left + 10;
    }

    final notchRect = Rect.fromLTWH(notchX, notchY, notchWidth, notchHeight);
    canvas.drawRect(notchRect, notchPaint);
    canvas.drawRect(notchRect, notchStrokePaint);
  }

  void _drawBenchNotchWithLines(Canvas canvas, Rect panelRect, PanelModel.Panel panel) {
    final notchPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final notchStrokePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final cutLinePaint = Paint()
      ..color = Colors.red.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double notchWidth = 60;
    final double notchHeight = 40;
    final double notchY = panelRect.bottom - notchHeight - 20;

    double notchX;
    if (panel.isNotchReversed) {
      notchX = panelRect.right - notchWidth - 10;
    } else {
      notchX = panelRect.left + 10;
    }

    final notchRect = Rect.fromLTWH(notchX, notchY, notchWidth, notchHeight);
    
    // Draw the notch cutout
    canvas.drawRect(notchRect, notchPaint);
    canvas.drawRect(notchRect, notchStrokePaint);

    // Draw cut lines showing where the notch will be cut
    // Horizontal cut lines (top and bottom of notch)
    canvas.drawLine(
      Offset(notchRect.left, notchRect.top),
      Offset(notchRect.right, notchRect.top),
      cutLinePaint,
    );
    canvas.drawLine(
      Offset(notchRect.left, notchRect.bottom),
      Offset(notchRect.right, notchRect.bottom),
      cutLinePaint,
    );

    // Vertical cut line (side of notch)
    if (panel.isNotchReversed) {
      // Right side cut line for reversed notch
      canvas.drawLine(
        Offset(notchRect.left, notchRect.top),
        Offset(notchRect.left, notchRect.bottom),
        cutLinePaint,
      );
    } else {
      // Left side cut line for normal notch  
      canvas.drawLine(
        Offset(notchRect.right, notchRect.top),
        Offset(notchRect.right, notchRect.bottom),
        cutLinePaint,
      );
    }

    // Add small extension lines to show cut continues to panel edge
    final extensionPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    if (panel.isNotchReversed) {
      // Extension to right edge
      canvas.drawLine(
        Offset(notchRect.right, notchRect.top),
        Offset(panelRect.right, notchRect.top),
        extensionPaint,
      );
      canvas.drawLine(
        Offset(notchRect.right, notchRect.bottom),
        Offset(panelRect.right, notchRect.bottom),
        extensionPaint,
      );
    } else {
      // Extension to left edge
      canvas.drawLine(
        Offset(panelRect.left, notchRect.top),
        Offset(notchRect.left, notchRect.top),
        extensionPaint,
      );
      canvas.drawLine(
        Offset(panelRect.left, notchRect.bottom),
        Offset(notchRect.left, notchRect.bottom),
        extensionPaint,
      );
    }
  }

  void _drawMeasurementLines(Canvas canvas, Rect panelRect, int panelIndex, PanelModel.Panel panel) {
    final measurementPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textStyle = const TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final double widthValue = panel.widthMm ?? 0;
    final double heightValue = panel.heightMm ?? 0;

    final widthText = widthValue > 0 ? '${widthValue.toInt()}mm' : 'W?';
    final heightText = heightValue > 0 ? '${heightValue.toInt()}mm' : 'H?';

    final widthTextPainter = TextPainter(
      text: TextSpan(text: widthText, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    widthTextPainter.layout();

    final heightTextPainter = TextPainter(
      text: TextSpan(text: heightText, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    heightTextPainter.layout();

    final double lineOffset = 20;
    
    canvas.drawLine(
      Offset(panelRect.left, panelRect.bottom + lineOffset),
      Offset(panelRect.right, panelRect.bottom + lineOffset),
      measurementPaint,
    );
    
    canvas.drawLine(
      Offset(panelRect.left, panelRect.bottom + lineOffset - 5),
      Offset(panelRect.left, panelRect.bottom + lineOffset + 5),
      measurementPaint,
    );
    
    canvas.drawLine(
      Offset(panelRect.right, panelRect.bottom + lineOffset - 5),
      Offset(panelRect.right, panelRect.bottom + lineOffset + 5),
      measurementPaint,
    );

    widthTextPainter.paint(
      canvas,
      Offset(
        panelRect.center.dx - widthTextPainter.width / 2,
        panelRect.bottom + lineOffset + 10,
      ),
    );

    canvas.drawLine(
      Offset(panelRect.right + lineOffset, panelRect.top),
      Offset(panelRect.right + lineOffset, panelRect.bottom),
      measurementPaint,
    );
    
    canvas.drawLine(
      Offset(panelRect.right + lineOffset - 5, panelRect.top),
      Offset(panelRect.right + lineOffset + 5, panelRect.top),
      measurementPaint,
    );
    
    canvas.drawLine(
      Offset(panelRect.right + lineOffset - 5, panelRect.bottom),
      Offset(panelRect.right + lineOffset + 5, panelRect.bottom),
      measurementPaint,
    );

    canvas.save();
    canvas.translate(
      panelRect.right + lineOffset + 15,
      panelRect.center.dy + heightTextPainter.width / 2,
    );
    canvas.rotate(-1.5708);
    heightTextPainter.paint(canvas, Offset.zero);
    canvas.restore();

    if (panel.hasBenchNotch) {
      _drawNotchMeasurements(canvas, panelRect, panel);
    }
  }

  void _drawNotchMeasurements(Canvas canvas, Rect panelRect, PanelModel.Panel panel) {
    final notchPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final textStyle = const TextStyle(
      color: Colors.green,
      fontSize: 10,
    );

    final double notchWidth = panel.notchHorizontalDepthMm ?? 0;
    final double notchHeight = panel.notchVerticalHeightMm ?? 0;

    final notchWidthText = notchWidth > 0 ? '${notchWidth.toInt()}' : 'NW?';
    final notchHeightText = notchHeight > 0 ? '${notchHeight.toInt()}' : 'NH?';

    final notchWidthTextPainter = TextPainter(
      text: TextSpan(text: notchWidthText, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    notchWidthTextPainter.layout();

    final notchHeightTextPainter = TextPainter(
      text: TextSpan(text: notchHeightText, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    notchHeightTextPainter.layout();

    final double notchDrawWidth = 60;
    final double notchDrawHeight = 40;
    final double notchY = panelRect.bottom - notchDrawHeight - 20;

    double notchX;
    if (panel.isNotchReversed) {
      notchX = panelRect.right - notchDrawWidth - 10;
    } else {
      notchX = panelRect.left + 10;
    }

    canvas.drawLine(
      Offset(notchX, notchY - 10),
      Offset(notchX + notchDrawWidth, notchY - 10),
      notchPaint,
    );

    notchWidthTextPainter.paint(
      canvas,
      Offset(notchX + notchDrawWidth / 2 - notchWidthTextPainter.width / 2, notchY - 25),
    );

    canvas.drawLine(
      Offset(notchX - 10, notchY),
      Offset(notchX - 10, notchY + notchDrawHeight),
      notchPaint,
    );

    canvas.save();
    canvas.translate(notchX - 25, notchY + notchDrawHeight / 2 + notchHeightTextPainter.width / 2);
    canvas.rotate(-1.5708);
    notchHeightTextPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}