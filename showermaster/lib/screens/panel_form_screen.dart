import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/panel.dart';
import '../models/user_settings.dart';
import '../providers/database_provider.dart';
import '../database/app_database.dart';
import '../widgets/notch_editor.dart';

class PanelFormScreen extends ConsumerStatefulWidget {
  final String showerId;
  final int index;
  final UnitPreference unit;

  const PanelFormScreen({
    super.key,
    required this.showerId,
    required this.index,
    required this.unit,
  });

  @override
  ConsumerState<PanelFormScreen> createState() => _PanelFormScreenState();
}

class _PanelFormScreenState extends ConsumerState<PanelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _widthMm;
  double? _heightMm;
  bool _isDoor = false;
  bool _hasBenchNotch = false;
  final Map<String, double> _notch = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel ${widget.index}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SwitchListTile(
                title: const Text('Is door panel'),
                value: _isDoor,
                onChanged: (val) => setState(() => _isDoor = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Width (${widget.unit.name})'),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  final raw = double.tryParse(val);
                  if (raw != null) {
                    _widthMm = widget.unit == UnitPreference.inches ? raw * 25.4 : raw;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (${widget.unit.name})'),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  final raw = double.tryParse(val);
                  if (raw != null) {
                    _heightMm = widget.unit == UnitPreference.inches ? raw * 25.4 : raw;
                  }
                },
              ),
              const SizedBox(height: 24),
              NotchEditor(
                enabled: _hasBenchNotch,
                unit: widget.unit,
                onToggle: (val) => setState(() => _hasBenchNotch = val),
                onChanged: (field, value) => _notch[field] = value,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final db = ref.read(dbProvider);
                  await db.insertPanel(
                    PanelsCompanion.insert(
                      id: const Uuid().v4(),
                      showerId: widget.showerId,
                      index: widget.index,
                      isDoor: _isDoor,
                      widthMm: Value(_widthMm),
                      heightMm: Value(_heightMm),
                      hasBenchNotch: Value(_hasBenchNotch),
                      notchVerticalOffsetMm: Value(_notch['notchVerticalOffsetMm']),
                      notchVerticalHeightMm: Value(_notch['notchVerticalHeightMm']),
                      notchHorizontalOffsetMm: Value(_notch['notchHorizontalOffsetMm']),
                      notchHorizontalDepthMm: Value(_notch['notchHorizontalDepthMm']),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save Panel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
