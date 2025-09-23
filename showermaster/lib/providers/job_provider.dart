import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final jobListProvider = FutureProvider<List<Job>>((ref) async {
  try {
    final db = ref.read(dbProvider);
    return await db.getAllJobs();
  } catch (e) {
    print('Error loading jobs: $e');
    // Return empty list if database fails
    return <Job>[];
  }
});
