import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/shower_measurement_view.dart';
import '../widgets/numeric_keypad.dart';

class MeasurementScreen extends ConsumerStatefulWidget {
  final String bathRoomName;
  
  const MeasurementScreen({
    super.key, 
    this.bathRoomName = 'Master Bathroom'
  });

  @override
  ConsumerState<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends ConsumerState<MeasurementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showKeypad = false;
  String? _selectedMeasurement;
  final Map<String, String> _measurements = {
    'width': '',
    'height': '',
    'depth': '',
  };

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
        title: Text(widget.bathRoomName),
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
            Tab(text: 'MEASURE'),
            Tab(text: 'OPTIONS'),
            Tab(text: 'NOTES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMeasureTab(),
          _buildOptionsTab(),
          _buildNotesTab(),
        ],
      ),
    );
  }

  Widget _buildMeasureTab() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Row(
                children: [
                  const Icon(Icons.straighten, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Text(
                    'Head slope is level',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Icon(Icons.help_outline, color: Colors.grey[400]),
                ],
              ),
            ),
            Expanded(
              child: ShowerMeasurementView(
                measurements: _measurements,
                onMeasurementTap: _onMeasurementTap,
              ),
            ),
          ],
        ),
        if (_showKeypad)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: NumericKeypad(
              selectedMeasurement: _selectedMeasurement!,
              onValueChanged: _onMeasurementValueChanged,
              onDismiss: () => setState(() => _showKeypad = false),
            ),
          ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: const Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ],
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

  void _onMeasurementTap(String measurementType) {
    setState(() {
      _selectedMeasurement = measurementType;
      _showKeypad = true;
    });
  }

  void _onMeasurementValueChanged(String value) {
    setState(() {
      _measurements[_selectedMeasurement!] = value;
    });
  }
}