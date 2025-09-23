import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../providers/database_provider.dart';
import '../database/app_database.dart';

class AssignShowerToVisitScreen extends ConsumerWidget {
  final String visitId;
  final String jobId;

  const AssignShowerToVisitScreen({
    super.key,
    required this.visitId,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(dbProvider);

    return FutureBuilder<List<Shower>>(
      future: db.getShowersForJob(jobId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final showers = snapshot.data!.where((s) => s.visitId == null).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Assign Shower')),
          body: ListView(
            children: showers.map((shower) {
              return ListTile(
                title: Text(shower.name),
                trailing: IconButton(
                  icon: const Icon(Icons.link),
                  onPressed: () async {
                    await (db.update(db.showers)..where((s) => s.id.equals(shower.id)))
                      .write(ShowersCompanion(visitId: Value(visitId)));
                    Navigator.pop(context);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
