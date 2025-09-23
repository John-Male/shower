import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/job_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: ShowerMasterApp()));
}


class ShowerMasterApp extends StatelessWidget {
  const ShowerMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowerMaster',
      theme: ThemeData(useMaterial3: true),
      home: const JobListScreen(),
    );
  }
}
