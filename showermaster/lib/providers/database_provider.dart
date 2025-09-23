import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  try {
    return AppDatabase();
  } catch (e) {
    print('Database initialization error: $e');
    // Return a database instance anyway - the error will be handled in operations
    return AppDatabase();
  }
});
