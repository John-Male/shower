import 'package:flutter/material.dart';
import '../models/panel.dart';
import '../models/user_settings.dart';
import '../widgets/notch_editor.dart';

class PanelEditorScreen extends StatefulWidget {
  final Panel panel;
  final UnitPreference unit;

  const PanelEditorScreen({super.key, required this.panel, required this.unit});

  @override
  State<PanelEditorScreen> createState() => _PanelEditorScreenState();
}

class _PanelEditorScreenState extends State<PanelEditorScreen> {
  late Panel panel;

  @override
  void initState() {
    super.initState();
    panel = widget.panel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Panel ${panel.index}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Width (${widget.unit.name})'),
              initialValue: panel.widthMm?.toStringAsFixed(1),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                final raw = double.tryParse(val);
                if (raw != null) {
                  setState(() {
                    panel.widthMm = widget.unit == UnitPreference.inches ? raw * 25.4 : raw;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Height (${widget.unit.name})'),
              initialValue: panel.heightMm?.toStringAsFixed(1),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                final raw = double.tryParse(val);
                if (raw != null) {
                  setState(() {
                    panel.heightMm = widget.unit == UnitPreference.inches ? raw * 25.4 : raw;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            NotchEditor(
              enabled: panel.hasBenchNotch,
              unit: widget.unit,
              onToggle: (val) => setState(() => panel.hasBenchNotch = val),
              onChanged: (field, value) {
                setState(() {
                  switch (field) {
                    case 'notchVerticalOffsetMm': panel.notchVerticalOffsetMm = value; break;
                    case 'notchVerticalHeightMm': panel.notchVerticalHeightMm = value; break;
                    case 'notchHorizontalOffsetMm': panel.notchHorizontalOffsetMm = value; break;
                    case 'notchHorizontalDepthMm': panel.notchHorizontalDepthMm = value; break;
                  }
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Save panel to state or DB
                Navigator.pop(context);
              },
              child: const Text('Save Panel'),
            ),
          ],
        ),
      ),
    );
  }
}
