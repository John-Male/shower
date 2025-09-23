import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../database/app_database.dart';
import '../models/visit.dart';
import '../providers/database_provider.dart';

class VisitFormScreen extends ConsumerStatefulWidget {
  final String jobId;
  final String? visitId; // null for new visit, set for editing
  
  const VisitFormScreen({super.key, required this.jobId, this.visitId});

  @override
  ConsumerState<VisitFormScreen> createState() => _VisitFormScreenState();
}

class _VisitFormScreenState extends ConsumerState<VisitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  DateTime _scheduledAt = DateTime.now();
  int _durationMinutes = 120;
  VisitStatus _status = VisitStatus.planned;
  
  bool get _isEditing => widget.visitId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadVisit();
    }
  }

  Future<void> _loadVisit() async {
    final db = ref.read(dbProvider);
    final visit = await db.getVisit(widget.visitId!);
    if (visit != null) {
      setState(() {
        _scheduledAt = visit.scheduledAt;
        _durationMinutes = visit.durationMinutes;
        _status = visit.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Visit' : 'New Visit'),
        actions: [
          if (_isEditing)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _deleteVisit();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete Visit'),
                ),
              ],
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Visit Details', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      
                      // Date and Time Picker
                      ListTile(
                        title: const Text('Scheduled Date & Time'),
                        subtitle: Text(_scheduledAt.toString().split('.')[0]),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: _selectDateTime,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Duration
                      TextFormField(
                        initialValue: _durationMinutes.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Duration (minutes)',
                          helperText: 'Estimated time for this visit',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => _durationMinutes = int.tryParse(val) ?? 120,
                        validator: (val) {
                          final duration = int.tryParse(val ?? '');
                          if (duration == null || duration <= 0) {
                            return 'Please enter a valid duration';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Status
                      DropdownButtonFormField<VisitStatus>(
                        value: _status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          helperText: 'Current status of this visit',
                        ),
                        items: VisitStatus.values.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Row(
                              children: [
                                Icon(
                                  status == VisitStatus.planned 
                                    ? Icons.schedule
                                    : status == VisitStatus.done
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: status == VisitStatus.planned 
                                    ? Colors.orange
                                    : status == VisitStatus.done
                                      ? Colors.green
                                      : Colors.red,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(status.name.toUpperCase()),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _status = val!),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveVisit,
                      child: Text(_isEditing ? 'Update Visit' : 'Create Visit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_scheduledAt),
      );
      
      if (time != null) {
        setState(() {
          _scheduledAt = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _saveVisit() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(dbProvider);
    
    try {
      if (_isEditing) {
        // Update existing visit
        await db.updateVisit(
          widget.visitId!,
          VisitsCompanion(
            scheduledAt: Value(_scheduledAt),
            durationMinutes: Value(_durationMinutes),
            status: Value(_status),
          ),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visit updated successfully!')),
        );
      } else {
        // Create new visit
        await db.insertVisit(
          VisitsCompanion.insert(
            id: const Uuid().v4(),
            jobId: widget.jobId,
            scheduledAt: _scheduledAt,
            durationMinutes: _durationMinutes,
            status: _status,
          ),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visit created successfully!')),
        );
      }
      
      Navigator.pop(context, true); // Return true to indicate success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving visit: $e')),
      );
    }
  }

  Future<void> _deleteVisit() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Visit'),
        content: const Text('Are you sure you want to delete this visit? This action cannot be undone.'),
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
        await db.deleteVisit(widget.visitId!);
        
        Navigator.pop(context); // Close this screen
        Navigator.pop(context); // Go back to job detail
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visit deleted successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting visit: $e')),
        );
      }
    }
  }
}