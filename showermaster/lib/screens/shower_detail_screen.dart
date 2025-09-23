import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../database/app_database.dart';
import '../models/shower.dart' show ShowerStyle, DoorType;
import '../models/panel.dart' as PanelModel;
import '../providers/database_provider.dart';
import '../widgets/photo_gallery.dart';
import '../widgets/visual_panel_editor.dart';

class ShowerDetailScreen extends ConsumerStatefulWidget {
  final String showerId;
  
  const ShowerDetailScreen({super.key, required this.showerId});

  @override
  ConsumerState<ShowerDetailScreen> createState() => _ShowerDetailScreenState();
}

class _ShowerDetailScreenState extends ConsumerState<ShowerDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _showVisualEditor = false;
  
  String _name = '';
  ShowerStyle _style = ShowerStyle.inline;
  DoorType _doorType = DoorType.left;
  int _panelCount = 3;
  List<PanelModel.Panel> _panels = [];

  // Helper function to convert model Panel to database Panel
  PanelModel.Panel _panelFromDb(Panel dbPanel) {
    return PanelModel.Panel(
      index: dbPanel.index,
      isDoor: dbPanel.isDoor,
      widthMm: dbPanel.widthMm,
      heightMm: dbPanel.heightMm,
      handleSide: dbPanel.handleSide,
      hasBenchNotch: dbPanel.hasBenchNotch,
      isNotchReversed: dbPanel.isNotchReversed,
      notchVerticalOffsetMm: dbPanel.notchVerticalOffsetMm,
      notchVerticalHeightMm: dbPanel.notchVerticalHeightMm,
      notchHorizontalOffsetMm: dbPanel.notchHorizontalOffsetMm,
      notchHorizontalDepthMm: dbPanel.notchHorizontalDepthMm,
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(dbProvider);
    
    return FutureBuilder(
      future: Future.wait([
        db.getShower(widget.showerId),
        db.getPanelsForShower(widget.showerId),
        db.getPhotosForEntity('Shower', widget.showerId),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        final shower = snapshot.data![0] as Shower?;
        if (shower == null) {
          return const Scaffold(
            body: Center(child: Text('Shower not found')),
          );
        }
        
        final panels = snapshot.data![1] as List<Panel>;
        final photos = snapshot.data![2] as List<Photo>;
        
        // Initialize form data if not editing
        if (!_isEditing) {
          _name = shower.name;
          _style = shower.style;
          _doorType = shower.doorType;
          _panelCount = shower.panelCount;
          _panels = panels.map(_panelFromDb).toList();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'Edit Shower' : shower.name),
            actions: [
              if (!_isEditing)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _saveShower,
                ),
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _deleteShower();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Shower'),
                  ),
                ],
              ),
            ],
          ),
          body: _isEditing ? _buildEditForm() : _buildDetailView(shower, panels, photos),
        );
      },
    );
  }

  Widget _buildDetailView(Shower shower, List<Panel> panels, List<Photo> photos) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic Information', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('Name: ${shower.name}'),
                Text('Style: ${shower.style.name}'),
                Text('Door Type: ${shower.doorType.name}'),
                Text('Panel Count: ${shower.panelCount}'),
                Text('Template ID: ${shower.templateId}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Panels (${panels.length})', style: Theme.of(context).textTheme.headlineSmall),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.settings),
                      label: const Text('Edit Panels'),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (panels.isEmpty)
                  const Text('No panels configured yet')
                else if (_isEditing)
                  VisualPanelEditor(
                    panels: _panels,
                    showerStyle: _style,
                    doorType: _doorType,
                    onPanelUpdated: _updatePanel,
                  )
                else
                  ...panels.map((panel) => _buildPanelTile(panel)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Photos', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                PhotoGallery(entityType: 'Shower', entityId: widget.showerId),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic Information', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _name,
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
                    initialValue: _panelCount.toString(),
                    decoration: const InputDecoration(labelText: 'Panel count'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final newCount = int.tryParse(val) ?? 3;
                      setState(() {
                        _panelCount = newCount;
                        _adjustPanelsList();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Panel Configuration', style: Theme.of(context).textTheme.headlineSmall),
                      ElevatedButton.icon(
                        icon: Icon(_showVisualEditor ? Icons.list : Icons.image),
                        label: Text(_showVisualEditor ? 'Form View' : 'Visual Editor'),
                        onPressed: () {
                          setState(() {
                            _showVisualEditor = !_showVisualEditor;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_showVisualEditor)
                    VisualPanelEditor(
                      panels: _panels,
                      showerStyle: _style,
                      doorType: _doorType,
                      onPanelUpdated: _updatePanel,
                    )
                  else ...[
                    ..._panels.asMap().entries.map((entry) => _buildPanelEditor(entry.key, entry.value)),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Panel'),
                      onPressed: _addPanel,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelTile(Panel panel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('Panel ${panel.index + 1}${panel.isDoor ? ' (Door)' : ''}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (panel.widthMm != null && panel.heightMm != null)
              Text('Size: ${panel.widthMm!.toStringAsFixed(1)} × ${panel.heightMm!.toStringAsFixed(1)} mm'),
            if (panel.hasBenchNotch)
              Text('Bench notch: ${panel.notchVerticalOffsetMm?.toStringAsFixed(1)}mm offset'),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelEditor(int index, PanelModel.Panel panel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Panel ${index + 1}', style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removePanel(index),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Is Door'),
              value: panel.isDoor,
              onChanged: (val) => _updatePanel(index, panel.copyWith(isDoor: val ?? false)),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: panel.widthMm?.toString() ?? '',
                    decoration: const InputDecoration(labelText: 'Width (mm)'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _updatePanel(
                      index, 
                      panel.copyWith(widthMm: double.tryParse(val)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: panel.heightMm?.toString() ?? '',
                    decoration: const InputDecoration(labelText: 'Height (mm)'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _updatePanel(
                      index, 
                      panel.copyWith(heightMm: double.tryParse(val)),
                    ),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Has Bench Notch'),
              value: panel.hasBenchNotch,
              onChanged: (val) => _updatePanel(index, panel.copyWith(hasBenchNotch: val ?? false)),
            ),
            if (panel.hasBenchNotch) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: panel.notchVerticalOffsetMm?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Notch V. Offset (mm)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _updatePanel(
                        index, 
                        panel.copyWith(notchVerticalOffsetMm: double.tryParse(val)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: panel.notchVerticalHeightMm?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Notch V. Height (mm)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _updatePanel(
                        index, 
                        panel.copyWith(notchVerticalHeightMm: double.tryParse(val)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: panel.notchHorizontalOffsetMm?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Notch H. Offset (mm)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _updatePanel(
                        index, 
                        panel.copyWith(notchHorizontalOffsetMm: double.tryParse(val)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: panel.notchHorizontalDepthMm?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Notch H. Depth (mm)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _updatePanel(
                        index, 
                        panel.copyWith(notchHorizontalDepthMm: double.tryParse(val)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _adjustPanelsList() {
    if (_panels.length > _panelCount) {
      _panels = _panels.take(_panelCount).toList();
    } else {
      while (_panels.length < _panelCount) {
        _panels.add(PanelModel.Panel(
          index: _panels.length,
          isDoor: false,
        ));
      }
    }
  }

  void _addPanel() {
    setState(() {
      _panels.add(PanelModel.Panel(
        index: _panels.length,
        isDoor: false,
      ));
      _panelCount = _panels.length;
    });
  }

  void _removePanel(int index) {
    setState(() {
      _panels.removeAt(index);
      // Update indices
      for (int i = 0; i < _panels.length; i++) {
        _panels[i] = _panels[i].copyWith(index: i);
      }
      _panelCount = _panels.length;
    });
  }

  void _updatePanel(int index, PanelModel.Panel updatedPanel) {
    setState(() {
      _panels[index] = updatedPanel.copyWith(index: index);
    });
  }

  Future<void> _saveShower() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(dbProvider);
    
    try {
      // Update shower basic info
      await db.updateShower(
        widget.showerId,
        ShowersCompanion(
          name: Value(_name),
          style: Value(_style),
          doorType: Value(_doorType),
          panelCount: Value(_panelCount),
        ),
      );

      // Delete existing panels and add new ones
      await db.deletePanelsForShower(widget.showerId);
      for (final panel in _panels) {
        await db.insertPanel(
          PanelsCompanion.insert(
            showerId: widget.showerId,
            index: panel.index,
            isDoor: panel.isDoor,
            widthMm: Value(panel.widthMm),
            heightMm: Value(panel.heightMm),
            hasBenchNotch: Value(panel.hasBenchNotch),
            notchVerticalOffsetMm: Value(panel.notchVerticalOffsetMm),
            notchVerticalHeightMm: Value(panel.notchVerticalHeightMm),
            notchHorizontalOffsetMm: Value(panel.notchHorizontalOffsetMm),
            notchHorizontalDepthMm: Value(panel.notchHorizontalDepthMm),
          ),
        );
      }

      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shower updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating shower: $e')),
      );
    }
  }

  Future<void> _deleteShower() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Shower'),
        content: const Text('Are you sure you want to delete this shower? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = ref.read(dbProvider);
      try {
        await db.deletePanelsForShower(widget.showerId);
        await db.deleteShower(widget.showerId);
        
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shower deleted successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting shower: $e')),
        );
      }
    }
  }
}