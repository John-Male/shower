import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../models/shower.dart';
import '../providers/database_provider.dart';
import '../database/app_database.dart';

class ShowerWizardScreen extends ConsumerStatefulWidget {
  final String jobId;
  const ShowerWizardScreen({super.key, required this.jobId});

  @override
  ConsumerState<ShowerWizardScreen> createState() => _ShowerWizardScreenState();
}

class _ShowerWizardScreenState extends ConsumerState<ShowerWizardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  ShowerStyle _style = ShowerStyle.inline;
  DoorType _doorType = DoorType.left;
  int _panelCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Shower')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Shower name'),
                onChanged: (val) => _name = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ShowerStyle>(
                value: _style,
                decoration: const InputDecoration(labelText: 'Style'),
                items: ShowerStyle.values.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s.name));
                }).toList(),
                onChanged: (val) => setState(() => _style = val!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<DoorType>(
                value: _doorType,
                decoration: const InputDecoration(labelText: 'Door type'),
                items: DoorType.values.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d.name));
                }).toList(),
                onChanged: (val) => setState(() => _doorType = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Panel count'),
                keyboardType: TextInputType.number,
                initialValue: '3',
                onChanged: (val) => _panelCount = int.tryParse(val) ?? 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final db = ref.read(dbProvider);
                    final showerId = const Uuid().v4();
                    
                    // Create the shower
                    await db.insertShower(
                      ShowersCompanion.insert(
                        id: showerId,
                        jobId: widget.jobId,
                        visitId: Value(null),
                        name: _name,
                        style: _style,
                        doorType: _doorType,
                        templateId: 'template-001', // TODO: link to template picker
                        panelCount: _panelCount,
                      ),
                    );

                    // Create default panels
                    for (int i = 0; i < _panelCount; i++) {
                      bool isDoor = false;
                      
                      // Set door panel based on door type and position
                      if (_doorType == DoorType.left && i == 0) {
                        isDoor = true;
                      } else if (_doorType == DoorType.right && i == _panelCount - 1) {
                        isDoor = true;
                      } else if (_doorType == DoorType.double && (i == 0 || i == _panelCount - 1)) {
                        isDoor = true;
                      }

                      await db.insertPanel(
                        PanelsCompanion.insert(
                          showerId: showerId,
                          index: i,
                          isDoor: isDoor,
                          widthMm: const Value(null),
                          heightMm: const Value(null),
                          hasBenchNotch: const Value(false),
                          notchVerticalOffsetMm: const Value(null),
                          notchVerticalHeightMm: const Value(null),
                          notchHorizontalOffsetMm: const Value(null),
                          notchHorizontalDepthMm: const Value(null),
                        ),
                      );
                    }
                    
                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Save Shower'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
