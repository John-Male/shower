import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../providers/database_provider.dart';
import 'job_detail_screen.dart';

class JobFormScreen extends ConsumerStatefulWidget {
  const JobFormScreen({super.key});

  @override
  ConsumerState<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends ConsumerState<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _startDate = DateTime.now();
  int _duration = 60;
  String _contactId = 'default-contact'; // TODO: link to contact picker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Job')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job name'),
                onChanged: (val) => _name = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Estimated duration (min)'),
                keyboardType: TextInputType.number,
                initialValue: '60',
                onChanged: (val) => _duration = int.tryParse(val) ?? 60,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final db = ref.read(dbProvider);
                    final jobId = const Uuid().v4();
                    await db.insertJob(
                      JobsCompanion.insert(
                        id: jobId,
                        name: _name,
                        startDate: _startDate,
                        estimatedDurationMinutes: _duration,
                        contactId: _contactId,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDetailScreen(jobId: jobId),
                      ),
                    );
                  }
                },
                child: const Text('Save Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
