import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../providers/database_provider.dart';
import '../widgets/photo_gallery.dart';

class VisitDetailScreen extends ConsumerWidget {
  final String visitId;
  const VisitDetailScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(dbProvider);

    return FutureBuilder(
      future: Future.wait([
        db.getPhotosForEntity('Visit', visitId),
        db.getShowersForJobVisit(visitId),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final photos = snapshot.data![0] as List<Photo>;
        final showers = snapshot.data![1] as List<Shower>;

        return Scaffold(
          appBar: AppBar(title: const Text('Visit Details')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Assigned Showers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...showers.map((shower) => ListTile(
                    title: Text(shower.name),
                    subtitle: Text('Style: ${shower.style}, Door: ${shower.doorType}'),
                    onTap: () {
                      // TODO: Navigate to shower detail or panel editor
                    },
                  )),
              const Divider(height: 32),
              const Text('Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              PhotoGallery(entityType: 'Visit', entityId: visitId),
            ],
          ),
        );
      },
    );
  }
}
