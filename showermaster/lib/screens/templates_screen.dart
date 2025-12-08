import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ShowerTemplate> _templates = [
    ShowerTemplate(
      id: '1',
      name: 'Inline Corner',
      category: 'Corner',
      doorType: DoorType.leftSwing,
    ),
    ShowerTemplate(
      id: '2',
      name: 'Corner L-Shape',
      category: 'Corner',
      doorType: DoorType.rightSwing,
    ),
    ShowerTemplate(
      id: '3',
      name: 'Inline Standard',
      category: 'Inline',
      doorType: DoorType.leftSwing,
    ),
    ShowerTemplate(
      id: '4',
      name: 'Inline Wide',
      category: 'Inline',
      doorType: DoorType.rightSwing,
    ),
  ];

  final List<StyleOption> _styleOptions = [
    StyleOption(name: 'STYLE: SQUARE', isSelected: true),
    StyleOption(name: 'DOORS: LEFT SWING DOOR', isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Location'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'TEMPLATES'),
            Tab(text: 'OPTIONS'),
            Tab(text: 'NOTES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTemplatesTab(),
          _buildOptionsTab(),
          _buildNotesTab(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return Column(
      children: [
        // Template grid
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
            children: _templates.map((template) => _buildTemplateCard(template)).toList(),
          ),
        ),
        
        const Divider(),
        
        // Style options
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ..._styleOptions.map((option) => _buildStyleOption(option)),
              const SizedBox(height: 16),
              // Style color options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColorOption(Colors.blue[300]!, true),
                  const SizedBox(width: 8),
                  _buildColorOption(Colors.blue[600]!, false),
                  const SizedBox(width: 8),
                  _buildColorOption(Colors.blue[900]!, false),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'DOORS: LEFT SWING DOOR',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              // Door style options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDoorStyleOption(Colors.blue[300]!, true),
                  const SizedBox(width: 8),
                  _buildDoorStyleOption(Colors.blue[600]!, false),
                  const SizedBox(width: 8),
                  _buildDoorStyleOption(Colors.blue[900]!, false),
                ],
              ),
            ],
          ),
        ),
        
        // Confirm button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Confirm Configuration',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateCard(ShowerTemplate template) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: CustomPaint(
                painter: TemplatePainter(template),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              template.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleOption(StyleOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            option.isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: option.isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            option.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: option.isSelected ? Colors.blue : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color, bool isSelected) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey[300]!,
          width: isSelected ? 3 : 1,
        ),
      ),
    );
  }

  Widget _buildDoorStyleOption(Color color, bool isSelected) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey[300]!,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: CustomPaint(
        painter: DoorStylePainter(color),
      ),
    );
  }

  Widget _buildOptionsTab() {
    return const Center(
      child: Text('Options content will go here'),
    );
  }

  Widget _buildNotesTab() {
    return const Center(
      child: Text('Notes content will go here'),
    );
  }
}

class ShowerTemplate {
  final String id;
  final String name;
  final String category;
  final DoorType doorType;

  ShowerTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.doorType,
  });
}

class StyleOption {
  final String name;
  final bool isSelected;

  StyleOption({
    required this.name,
    required this.isSelected,
  });
}

enum DoorType {
  leftSwing,
  rightSwing,
}

class TemplatePainter extends CustomPainter {
  final ShowerTemplate template;

  TemplatePainter(this.template);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;

    // Draw different template shapes based on category
    switch (template.category) {
      case 'Corner':
        _drawCornerTemplate(canvas, size, paint, fillPaint);
        break;
      case 'Inline':
        _drawInlineTemplate(canvas, size, paint, fillPaint);
        break;
    }

    // Draw door indicator
    _drawDoorIndicator(canvas, size, template.doorType);
  }

  void _drawCornerTemplate(Canvas canvas, Size size, Paint strokePaint, Paint fillPaint) {
    final path = Path();
    
    // L-shaped shower
    path.moveTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawInlineTemplate(Canvas canvas, Size size, Paint strokePaint, Paint fillPaint) {
    final rect = Rect.fromLTWH(
      size.width * 0.2,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.4,
    );

    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, strokePaint);
  }

  void _drawDoorIndicator(Canvas canvas, Size size, DoorType doorType) {
    final doorPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final doorWidth = size.width * 0.15;
    late Offset doorStart;
    late Offset doorEnd;

    switch (doorType) {
      case DoorType.leftSwing:
        doorStart = Offset(size.width * 0.2, size.height * 0.3);
        doorEnd = Offset(size.width * 0.2 + doorWidth, size.height * 0.3);
        break;
      case DoorType.rightSwing:
        doorStart = Offset(size.width * 0.8 - doorWidth, size.height * 0.3);
        doorEnd = Offset(size.width * 0.8, size.height * 0.3);
        break;
    }

    canvas.drawLine(doorStart, doorEnd, doorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DoorStylePainter extends CustomPainter {
  final Color color;

  DoorStylePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw door swing indicator
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    canvas.drawCircle(center, radius, paint);
    canvas.drawLine(
      center,
      Offset(center.dx + radius, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}