import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_provider.dart';
import 'job_form_screen.dart';
import 'job_detail_screen.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: jobsAsync.when(
        data: (jobs) => ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return ListTile(
              title: Text(job.name),
              subtitle: Text('Duration: ${job.estimatedDurationMinutes} min'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailScreen(jobId: job.id),
                  ),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const JobFormScreen()),
          );
          // Refresh the job list after returning from the form
          ref.invalidate(jobListProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
