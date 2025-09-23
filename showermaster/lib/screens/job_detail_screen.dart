import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../models/visit.dart' show VisitStatus;
import '../providers/database_provider.dart';
import 'shower_wizard_screen.dart';
import 'shower_detail_screen.dart';
import 'visit_detail_screen.dart';
import 'visit_form_screen.dart';
import '../widgets/photo_gallery.dart';
import 'assign_shower_to_visit_screen.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  late Future<List<dynamic>> _dataFuture;

  static Future<void> _deleteVisit(BuildContext context, WidgetRef ref, String visitId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Visit'),
        content: const Text('Are you sure you want to delete this visit?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(dbProvider).deleteVisit(visitId);
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

  static Future<void> _deleteShower(BuildContext context, WidgetRef ref, String showerId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Shower'),
        content: const Text('Are you sure you want to delete this shower? All panel data will be lost.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(dbProvider).deletePanelsForShower(showerId);
        await ref.read(dbProvider).deleteShower(showerId);
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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final db = ref.read(dbProvider);
    _dataFuture = Future.wait([
      db.getVisitsForJob(widget.jobId),
      db.getShowersForJob(widget.jobId),
      db.getPhotosForEntity('Job', widget.jobId),
    ]);
  }

  void _refreshData() {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final visits = snapshot.data![0] as List<Visit>;
        final showers = snapshot.data![1] as List<Shower>;
        final photos = snapshot.data![2] as List<Photo>;

        return Scaffold(
          appBar: AppBar(title: const Text('Job Details')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Visits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Visit'),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VisitFormScreen(jobId: widget.jobId),
                        ),
                      );
                      if (result == true) {
                        _refreshData();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (visits.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No visits scheduled yet'),
                )
              else
                ...visits.map((visit) => Card(
                  child: ListTile(
                    leading: Icon(
                      visit.status == VisitStatus.planned 
                        ? Icons.schedule
                        : visit.status == VisitStatus.done
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: visit.status == VisitStatus.planned 
                        ? Colors.orange
                        : visit.status == VisitStatus.done
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text('Visit on ${visit.scheduledAt.toLocal().toString().split(' ')[0]}'),
                    subtitle: Text('${visit.durationMinutes} min • Status: ${visit.status.name}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VisitFormScreen(jobId: widget.jobId, visitId: visit.id),
                            ),
                          );
                          if (result == true) {
                            _refreshData();
                          }
                        } else if (value == 'delete') {
                          await _deleteVisit(context, ref, visit.id);
                          _refreshData();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VisitDetailScreen(visitId: visit.id),
                      ),
                    ),
                  ),
                )),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Showers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Shower'),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShowerWizardScreen(jobId: widget.jobId),
                        ),
                      );
                      if (result == true) {
                        _refreshData();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (showers.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No showers added yet'),
                )
              else
                ...showers.map((shower) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.bathtub),
                    title: Text(shower.name),
                    subtitle: Text('${shower.style.name} • ${shower.doorType.name} door • ${shower.panelCount} panels'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShowerDetailScreen(showerId: shower.id),
                            ),
                          );
                          if (result == true) {
                            _refreshData();
                          }
                        } else if (value == 'delete') {
                          await _deleteShower(context, ref, shower.id);
                          _refreshData();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ShowerDetailScreen(showerId: shower.id),
                      ),
                    ),
                  ),
                )),
              const Divider(height: 32),
              const Text('Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              PhotoGallery(entityType: 'Job', entityId: widget.jobId),
            ],
          ),
        );
      },
    );
  }
}
