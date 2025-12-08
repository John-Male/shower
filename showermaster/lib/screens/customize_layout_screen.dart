import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomizeLayoutScreen extends ConsumerStatefulWidget {
  const CustomizeLayoutScreen({super.key});

  @override
  ConsumerState<CustomizeLayoutScreen> createState() => _CustomizeLayoutScreenState();
}

class _CustomizeLayoutScreenState extends ConsumerState<CustomizeLayoutScreen> {
  final int _selectedPanelIndex = 0;
  final double _rotationAngle = 90.0;

  final List<PanelConfiguration> _panelConfigurations = [
    PanelConfiguration(
      title: 'Panel at Position 2',
      panels: [
        PanelStyle.straightLeft,
        PanelStyle.straightRight,
        PanelStyle.notchedLeft,
        PanelStyle.notchedRight,
        PanelStyle.angledLeft,
        PanelStyle.angledRight,
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Layout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Main layout area
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[50],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Left panel
                    _buildPanelShape(PanelStyle.straightLeft),
                    // Right panel  
                    _buildPanelShape(PanelStyle.straightRight),
                  ],
                ),
              ),
            ),
          ),
          
          // Add buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAddButton(),
                _buildAddButton(),
              ],
            ),
          ),
          
          // Rotation control
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.rotate_left),
                Text(' ${_rotationAngle.toInt()}°'),
                const Spacer(),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Panel configuration section
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Panel at Position 2',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Panel style grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: _panelConfigurations[_selectedPanelIndex]
                        .panels
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final panelStyle = entry.value;
                      final isSelected = index == 1; // Default to second option selected
                      
                      return _buildPanelOption(panelStyle, isSelected);
                    }).toList(),
                ),
                ),
                
                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Delete Panel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelShape(PanelStyle style) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
      ),
      child: CustomPaint(
        painter: PanelPainter(style),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 2),
        color: Colors.white,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildPanelOption(PanelStyle style, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Handle panel selection
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue[50] : Colors.white,
        ),
        child: CustomPaint(
          painter: PanelOptionPainter(style, isSelected),
        ),
      ),
    );
  }
}

enum PanelStyle {
  straightLeft,
  straightRight,
  notchedLeft,
  notchedRight,
  angledLeft,
  angledRight,
}

class PanelConfiguration {
  final String title;
  final List<PanelStyle> panels;

  PanelConfiguration({
    required this.title,
    required this.panels,
  });
}

class PanelPainter extends CustomPainter {
  final PanelStyle style;

  PanelPainter(this.style);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw door handle
    final handleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.4, 4, size.height * 0.2),
      const Radius.circular(2),
    );
    canvas.drawRRect(handleRect, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PanelOptionPainter extends CustomPainter {
  final PanelStyle style;
  final bool isSelected;

  PanelOptionPainter(this.style, this.isSelected);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Colors.blue : Colors.grey[600]!
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = isSelected ? Colors.blue : Colors.grey[400]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw panel shape based on style
    switch (style) {
      case PanelStyle.straightLeft:
      case PanelStyle.straightRight:
        final rect = Rect.fromLTWH(
          size.width * 0.2,
          size.height * 0.1,
          size.width * 0.6,
          size.height * 0.8,
        );
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect, outlinePaint);
        break;
        
      case PanelStyle.notchedLeft:
      case PanelStyle.notchedRight:
        final path = Path();
        path.moveTo(size.width * 0.2, size.height * 0.1);
        path.lineTo(size.width * 0.8, size.height * 0.1);
        path.lineTo(size.width * 0.8, size.height * 0.5);
        path.lineTo(size.width * 0.6, size.height * 0.5);
        path.lineTo(size.width * 0.6, size.height * 0.9);
        path.lineTo(size.width * 0.2, size.height * 0.9);
        path.close();
        canvas.drawPath(path, paint);
        canvas.drawPath(path, outlinePaint);
        break;
        
      case PanelStyle.angledLeft:
      case PanelStyle.angledRight:
        final path = Path();
        path.moveTo(size.width * 0.2, size.height * 0.1);
        path.lineTo(size.width * 0.8, size.height * 0.1);
        path.lineTo(size.width * 0.8, size.height * 0.9);
        path.lineTo(size.width * 0.4, size.height * 0.9);
        path.close();
        canvas.drawPath(path, paint);
        canvas.drawPath(path, outlinePaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}